These are mostly scattered notes of what you might find while building an Android application.

As you might notice this document starts with [testing] and [performance]. These are topics that are often left to the end of the priorities and the source for a lot of  baggage that is not easy to get rid of. At this time they are the topics which always trigger me the thought of "what could have I done better to" make this more **testable** or **performant**

As somewhat of a warning, these are my opinions and always take with a grain of salt what you read in the internet. That said, I like to think I have a pragmatic approach to most things related to programming. If you read something here and think that that's not the way it's done, at least give the idea some chance. I do not give any guarantee that everything that I write here actually matches with what I do when I work with another people since that's another factor you absolutely need to consider.

# Testing

Let's just start by establishing that the way an Android application is built (the build system, I mean) is super convoluted. It's slow even for the project that you are left with when you create a new project in Android Studio.

How is that related to testing? You want to test what you're doing **fast**, it will be a pain for you to actually iterate your solution if it takes like, more that 5 seconds (optimistic value). Keeping in mind the first section, running your tests locally (not in the device) will grant more chances of success in terms of speed. If your code relies on Android Libraries, there's a good chance that you won't be able to run the tests locally without entering the world of [mocking libraries] or some sort of [dependency injection library], which will absolutely cause you additional pain because that's now another thing you have to deal with. When possible, keep what you do detached from large Android libraries in another module. It will be easier to test and iterate, only at the cost of extra glue clue to integrate with the rest of the Android code that actually has to exist.

## What about User Interface stuff?

This is not something I've tried, but if it's about Views, or interactions that do not involve multiple screens, having a debug screen that displays all of your Views and variants it's a good way to iterate fast, without waiting for everything on your application to start. For example, if the application has multiple screens, have a debug screen that displays all of your views in a list and add the ability to change the theme there.

For all other cases, you have the regular suspects, Espresso, UiAutomator, Robolectric and all the variants. They are not ideal, since you then have to worry about [flakiness] and everything else that is happening in the Phone at the time. Sometimes you just can't get around without using them.

# Performance

This will a rant filled section, since my frustration with [JVM] adjacent things is ever growing. It's not about what you have, but what you are losing (more on this later).

## Garbage collection

As we work with Java/Kotlin most of the times we hand wave most of the things related to memory. But from my experience, this approach will most likely come back to haunt you. You will receive a trace from Play Store describing that your application took too long to respond in the main thread because the system was >>garbage collecting<<.
Depending on the case:

- it's not your fault.
- You can solve it because it's a local problem.
- It's too late, it would require too many changes and you don't have the time resources to fix it. The users will call your application a piece of junk because it's always freezing.

Garbage collection it's always being improved, currently allocations are pretty cheap, but keep in mind that they are not free.

## Data oriented design and cache misses

NOTE: Is this a thing that the world of Java/Kotlin completely throws away? **incomplete**

## Optimization

Lack of optimisation guarantees by default. Do not expect your code to be optimised as you expect, or at all.
**incomplete**

# Activities

# Fragments

# Services

# Adapters

# Threading

# Bitfields (to be moved in to separate file)

# Exceptions and Errors

Guarantees that a method won't actually blow up on you.
Do not abuse the exception system. Handle errors explicitly.

**incomplete**

# Separate thoughts

## Testing and the surrounding programming environment.

This is an incomplete thought on how the programming environment you're in absolutely bends some aspects of how things are done.
If you could replace a class or method easily during runtime/testing how simpler could things be, at least in the testing process? You can absolutely do this in some languages (python?).
Dependency injection (DI) claims to be mostly directed at making your code be cleanly divided by concerns and making your code more testable.
Does it actually have a place for testing if you can replace some parts of the functionality during tests without changing the main project code?
I'm not big fan of making the compilation pipeline even more complex by attaching another step to generate code that I will never have control over (the output at least) and on top of that, if your main goal with DI is testability, it absolutely leaks over the main project as you now have to go to the extra effort in making everything to be an interface. This adds yet another layer and Java stacktraces are already so deep that they are a parody of themselves.

## Subclassing madness on core components (Activity/Fragment)

Subclassing is really convenient, can't really deny it.
Create a BaseFragment and every other similar Fragment just works in the same way, right?

The issue arises when you need to changes at the middle of the subclass tree. Now if something breaks you probably broke everything that comes after it. BaseFragment needs a little tweak but one of the subclasses doesn't? It's time for workarounds so everything stays the same except that particular thing.
This is nothing new, you're being told everywhere to prefer composition over inheritance but that doesn't seem to be applied often in Activity/Fragment's.
Another pain point is that now you're stuck with thinking in layers which are not cleanly divided, especially with the quantity of lifecycle methods an Activity of Fragment can have, on top, you can choose to call super methods at the start, middle or end of the method. It's an accordion of behaviors.
Now, I'm not sure what's the best approach, another class that it's a delegate of everything that would be called there? the same issue can happen again. Pure functions / static methods without side effects? sounds so not-java like.