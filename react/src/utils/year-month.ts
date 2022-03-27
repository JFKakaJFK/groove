/**
 * Helper class to do the date logic needed
 * 
 * I was thinking of trying the new temporal api for this
 * but the polyfills I looked at did not seem mature enough
 * yet :/
 */
export class YearMonth {
  /** first day of this month*/
  readonly date: Date

  static fromDate(d: Date) {
    return new YearMonth(d.getFullYear(), d.getMonth() + 1)
  }

  constructor(year: string | number | null, month: string | number | null) {
    const today = new Date();
    const y = (+(year ?? 0)) || today.getFullYear(), m = ((+(month ?? 0)) || today.getMonth() + 1) - 1;
    this.date = new Date(y, m, 1)
  }

  get offset(): number {
    // the week starts with monday here.
    return (this.date.getDay() + 6) % 7
  }

  /**
   * First day of the month or if that is not 
   * a monday the last monday of the previous month
   */
  get start(): Date {
    const s = new Date(this.date)
    // s.setDate(this.date.getDate() - this.day(this.date))
    return s
  }

  /**
   * Last day of the month or if that is not a sunday
   * the first sunday of the next month
   */
  get end(): Date {
    const e = new Date(this.date.getFullYear(), this.date.getMonth() + 1, 1) // first day of next month
    e.setDate(0) // last day of this month
    // if (e.getDay() !== 0) {
    //   e.setDate(e.getDate() + 7 - e.getDay())
    // }
    return e
  }

  get prev(): YearMonth {
    const p = new Date(this.date)
    p.setDate(0)
    return YearMonth.fromDate(p)
  }

  get hasNext(): boolean {
    return this.next.start < new Date()
  }

  get next(): YearMonth {
    return new YearMonth(this.date.getFullYear(), this.date.getMonth() + 2)
  }

  get ym(): { year: string, month: string } {
    return {
      year: this.date.getFullYear().toString(),
      month: (this.date.getMonth() + 1).toString()
    }
  }

  toString(): string {
    return this.date.toLocaleDateString("default", {
      month: "long",
      year: "numeric",
    })
  }
}