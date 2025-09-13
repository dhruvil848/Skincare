//
//  Utility.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 11/09/25.
//

import SwiftUI

class Utility {
    static let dailySkincareTips: [String] = [
        "Don't forget SPF even when staying indoors – UV rays can penetrate windows! ☀️",
        "Hydrate your skin from the inside out – drink at least 8 glasses of water today. 💧",
        "Cleanse your face gently to remove dirt and oil without stripping natural moisture. 🧼",
        "Moisturize daily to maintain a healthy skin barrier. 🧴",
        "Get enough sleep – your skin repairs itself while you rest. 😴",
        "Use a gentle exfoliator 1-2 times a week to remove dead skin cells. ✨",
        "Avoid touching your face frequently – it helps prevent breakouts. ✋❌",
        "Apply antioxidant serum in the morning to protect skin from environmental damage. 🍊",
        "Remove makeup before bed to allow your skin to breathe overnight. 💄➡️🛏️",
        "Keep your skincare products stored in a cool, dry place to maintain effectiveness. 🧊",
        "Limit excessive sugar intake – it can contribute to skin inflammation. 🍬❌",
        "Wear sunglasses to protect the delicate skin around your eyes from UV rays. 🕶️",
        "Patch test new products to avoid allergic reactions or irritation. 🧪",
        "Consistency is key – stick to your routine for visible results. 📅",
        "Remember to clean your phone screen regularly – it touches your face! 📱🧼",
        "Change pillowcases regularly to avoid transferring oil and dirt to your skin. 🛏️",
        "Incorporate a gentle toner to balance your skin’s pH after cleansing. ⚖️",
        "Use lukewarm water, not hot, to cleanse your skin and prevent dryness. 💦",
        "Massage your face gently to improve blood circulation and promote glow. 💆‍♀️",
        "Avoid over-exfoliating – it can cause sensitivity and redness. ❌",
        "Apply sunscreen 15–30 minutes before going outside for best protection. 🕒",
        "Use a moisturizer with hyaluronic acid to boost skin hydration. 💧",
        "Take short breaks from screens to prevent eye strain and skin fatigue. 👀",
        "Limit stress – high stress can trigger acne and other skin issues. 😌",
        "Eat foods rich in omega-3 fatty acids to maintain healthy skin. 🥑🐟",
        "Use gentle, fragrance-free products if your skin is sensitive. 🌸",
        "Avoid popping pimples to prevent scarring and infection. ❌",
        "Consider a weekly face mask for hydration, brightening, or calming. 🛁",
        "Use a lip balm with SPF to protect your lips from sun damage. 💋☀️",
        "Drink green tea – antioxidants help fight free radicals affecting skin. 🍵",
        "Wash your hands before touching your face or applying skincare. 🖐️",
        "Rotate your pillow and mattress for even sleep pressure distribution. 🛏️",
        "Avoid excessive caffeine – it can dehydrate your skin. ☕❌",
        "Incorporate vitamin C serum to brighten skin and reduce pigmentation. 🍊",
        "Use an eye cream to combat puffiness and dark circles. 👁️",
        "Avoid smoking – it accelerates skin aging and dullness. 🚭",
        "Moisturize immediately after showering to lock in hydration. 🚿🧴",
        "Use a gentle cleanser at night to remove dirt, oil, and pollution. 🌙",
        "Avoid harsh scrubbing; let exfoliants do the work. 🧽",
        "Stay consistent with your routine, even on weekends. 📅",
        "Use a humidifier in dry climates to prevent skin dehydration. 💨",
        "Apply skincare in order: cleanse → tone → serum → moisturizer → sunscreen. 🧴➡️☀️",
        "Protect your hands with SPF; they show early signs of aging. 🖐️☀️",
        "Avoid excessive sun exposure between 10 AM – 4 PM. 🌞",
        "Use fragrance-free laundry detergents to prevent skin irritation. 🧺",
        "Incorporate probiotics in your diet to support skin health. 🥛",
        "Use retinol at night to improve skin texture and reduce fine lines. 🌙",
        "Be gentle when removing makeup – don’t tug or rub your skin. 💄🧴",
        "Incorporate facial oils if your skin feels dry, especially in winter. ❄️🛢️",
        "Apply aloe vera to calm irritated or sunburned skin. 🌿",
        "Keep track of triggers if you have sensitive or acne-prone skin. 📝",
        "Avoid hot showers; they strip natural oils and dry out skin. 🚿❌",
        "Limit alcohol – it can dehydrate your skin and worsen redness. 🍷❌",
        "Use a broad-spectrum sunscreen with SPF 30+ daily. ☀️🛡️",
        "Exfoliate lips gently with a sugar scrub to prevent chapping. 🍬💋",
        "Incorporate antioxidants in your diet like berries and nuts. 🍓🥜",
        "Massage neck and jawline to prevent sagging and improve circulation. 💆‍♂️",
        "Be mindful of pillowcase material – silk reduces friction and wrinkles. 🛏️",
        "Use eye patches or masks for extra hydration and de-puffing. 👁️✨",
        "Avoid over-cleansing – twice a day is sufficient for most skin types. 🧼",
        "Pat your face dry instead of rubbing with a towel. 🧻",
        "Use gentle, non-comedogenic sunscreen for acne-prone skin. ☀️",
        "Check expiration dates on skincare products to maintain efficacy. ⏰",
        "Avoid touching your face with dirty hands, especially during work. 🖐️💻",
        "Incorporate vitamin E-rich foods to support skin repair. 🌰🥑",
        "Use hydrating masks if your skin feels tight or dry. 🛁💧",
        "Avoid using too many products at once – stick to essentials. ⚖️",
        "Rinse off sweat after workouts to prevent clogged pores. 🏋️‍♀️💦",
        "Moisturize sensitive areas like elbows, knees, and feet. 🦵🧴",
        "Apply sunscreen even on cloudy days – up to 80% UV can penetrate clouds. ☁️☀️",
        "Be patient – skincare results often take 4–6 weeks to show. ⏳",
        "Include zinc in your diet to support skin healing. 🥩🥜",
        "Use a serum with niacinamide to reduce redness and inflammation. 🔬",
        "Avoid exfoliating every day – 1–3 times per week is enough. 🧽",
        "Apply toner gently using a cotton pad or hands. 👐",
        "Limit long hot baths; they can strip your skin’s natural oils. 🛁❌",
        "Incorporate foods rich in vitamin A for skin repair and health. 🥕",
        "Use gentle wipes for makeup removal, not harsh scrubs. 💄🧴",
        "Wash makeup brushes weekly to prevent bacteria buildup. 🖌️🧼",
        "Apply moisturizer in upward motions to help lift skin. ⬆️",
        "Keep hydrated – dehydration can cause dull skin and fine lines. 💦",
        "Take short breaks from screens to reduce blue-light stress. 💻👀",
        "Use gentle shampoo and conditioner to avoid irritation on the face. 🧴",
        "Check skincare labels for alcohol or sulfates if you have sensitive skin. ⚠️",
        "Apply sunscreen to ears, neck, and hands – often forgotten areas. 👂🖐️",
        "Incorporate omega-3 supplements or foods for skin elasticity. 🐟🥑",
        "Consider a weekly double-cleansing if you wear heavy makeup. 💄🧼",
        "Avoid sleeping with makeup on – it causes clogged pores. 🛏️💄❌",
        "Use facial mists for a quick hydration boost during the day. 💦",
        "Apply eye cream before moisturizer for better absorption. 👁️🧴",
        "Limit spicy foods if prone to rosacea or redness. 🌶️❌",
        "Keep nails trimmed to avoid scratching face accidentally. ✋✂️",
        "Use gentle massage tools like jade rollers for relaxation. 💆‍♀️💎",
        "Try to maintain a consistent sleep schedule for skin repair. 🛏️🕒",
        "Avoid touching acne-prone areas to prevent spreading bacteria. ✋❌",
        "Apply retinol at night and always use sunscreen during the day. 🌙☀️",
        "Use a gentle cleanser suited to your skin type – don’t copy others. 🧼",
        "Incorporate natural remedies like green tea or chamomile for calmness. 🍵🌿",
        "Moisturize after washing hands to prevent dryness and cracking. 🖐️🧴",
        "Use SPF even on your lips – choose a lip balm with SPF. 💋☀️",
        "Check ingredients for potential irritants if you have sensitive skin. ⚠️",
        "Be mindful of diet – processed foods may affect your skin’s clarity. 🍟❌",
        "Keep a skincare journal to track results and reactions. 📓🖊️",
        "Use hydrating sheet masks once or twice a week for extra care. 🛁✨",
        "Always remove sunscreen at the end of the day before bedtime. 🧴🌙",
        "Stay consistent, even on holidays or travel – small lapses add up. ✈️📅"
    ]

    class func getDailyTip() -> String {
        let tipCount = dailySkincareTips.count
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
        let tipIndex = (dayOfYear - 1) % tipCount  // loops back to 0 after the last tip
        let dailyTip = dailySkincareTips[tipIndex]
        
        return dailyTip
    }
    
    class func streakMessage(streak: Int16?) -> String {
        guard let completedDays = streak else { return "" }

        switch completedDays {
        case 0:
            return "Let's start your first routine! 🌱"
        case 1:
            return "Great! You've taken the first step. 👏"
        case 2:
            return "Good going! Keep the momentum. 🔥"
        case 3:
            return "Halfway through the week! Keep it up! 💪"
        case 4:
            return "Awesome! You're on a roll! ✨"
        case 5:
            return "Impressive! Almost there! 🌟"
        case 6:
            return "Just one more day to complete the week! 🏁"
        case 7:
            return "Amazing! You completed the week! Take a moment to celebrate! 🎉"
        case 8...10:
            return "Unstoppable! You're building a strong habit! 💯"
        case 11...14:
            return "Legendary streak! Your skin routine is solid! 🏆"
        case 15...20:
            return "Epic! Your consistency is inspiring! 🌟"
        default:
            return "Keep your streak alive! Consistency is key! 💖"
        }
    }
    
    class func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 5..<12:
            return "Good Morning! 👋🏻"
        case 12..<17:
            return "Good Afternoon! 👋🏻"
        case 17..<21:
            return "Good Evening! 👋🏻"
        default:
            return "Good Night! 👋🏻"
        }
    }
}
