Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2398820E01D;
	Tue, 13 May 2025 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126216; cv=none; b=axnc/JxU5+X8aFfqA6nSVEOQWd43uuJY4xtPZSiqeU5xBqIah3Uts3JqBtWL8am9htLZSS6UY26bd8Iolkx2sv2gCWm+zP7IOc1fIGGCwVSHCNFcwlKNstgtXuRYw3tCKR5hhkF869JPs3kmOdOW9ejiZn0g6KFt3hXUbbeeV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126216; c=relaxed/simple;
	bh=/nibn578vZOL+hUDaUM1fUFqT5nRB7yoR4NZaKcKSO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfuTwT3TjYxbTRkE6rlIHHBsXP5EsLyYcIkaEuSNzKaUD4WcyvRaDRheHnRsrHIfVLoaKQ1joWBxw7SalHL+d3tHpQnvy5Qa+AC334Jpxoefo1+/tcGOtUx4rXP4hKnGPbZ2D8y0PUSsvz20xwTBvyb35tWaPnMNgiRYqZT4qew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YvV9D8wh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YvV9D8wh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=28pLVNytT2velBslcXHg/uRI9gTATvHagNVAmVsnu9Y=; b=YvV9D8whVl2Kxo94z7NOLLKoAu
	7GZEsxUKFixGDkQLAv0c4/4V+KdOtdyu8nb8Lz/rOciSar3mJBXvOJ34/iUyXWp1pqBWlh9MrMZMz
	vMfwTMhHmdtT1PgOdKCDZM1ikqKTkTOSNM3ixDAgySYuPYjNBj2aLKjzXVN1Q+lnJJSRIBbrkFDl4
	eLrFoz8AuCj09/5FOPMN+CjQApndtwaftgYvMMHp9hd8D4TBOzZscYSMqaZdCqJQJ0spHA7eOUOR5
	3nRHhM++/P4Ov0k2YzFjtwRu9h62cKH+YXHAQezAbhKFUax2E+YlAmbaWFFYnWF6Z+z5wFmegmfYJ
	Kn/jqqEg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uElKs-0000000Gtt0-0yfH;
	Tue, 13 May 2025 08:50:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9710F30066A; Tue, 13 May 2025 10:50:01 +0200 (CEST)
Date: Tue, 13 May 2025 10:50:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/7] cleanup: Introduce DEFINE_ACQUIRE() a CLASS() for
 conditional locking
Message-ID: <20250513085001.GC25891@noisy.programming.kicks-ass.net>
References: <681bce2193f38_1229d6294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20250508110043.GG4439@noisy.programming.kicks-ass.net>
 <681d8ce06c869_1229d6294e@dwillia2-xfh.jf.intel.com.notmuch>
 <20250509104028.GL4439@noisy.programming.kicks-ass.net>
 <681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch>
 <20250512105026.GP4439@noisy.programming.kicks-ass.net>
 <20250512182559.GB25891@noisy.programming.kicks-ass.net>
 <20250512185817.GA1808@noisy.programming.kicks-ass.net>
 <CAHk-=whxPoFnZ4cLKh4X3m4qVcaak__G8+0iG-aOGO7YkS3LdA@mail.gmail.com>
 <20250513070918.GB25763@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513070918.GB25763@noisy.programming.kicks-ass.net>

On Tue, May 13, 2025 at 09:09:18AM +0200, Peter Zijlstra wrote:
> On Mon, May 12, 2025 at 01:39:19PM -0700, Linus Torvalds wrote:

> > If you *really* care about this, I think you should realize that the
> > non-error case is a valid kernel pointer.
> > 
> > And we could add some architecture-specific function to check for "is
> > this a valid non-NULL and non-error pointer" with a fallback to the
> > generic case.
> > 
> > Because then on a platform like x86, where kernel pointers are always
> > negative, but not *as* negative as the error pointers, you can check
> > for that with a single compare.
> > 
> > The logic is "add MAX_ERRNO, and if it's still negative, it wasn't
> > NULL and it wasn't ERR_PTR".
> > 
> > And while 'add' needs a destination register, 'sub' with the negated
> > value does not, and is called 'cmp'.
> > 
> > So I think you can do that with
> > 
> >         cmp $-MAX_ERRNO,...
> >         js ...
> > 
> > Sadly, I can't seem to get gcc to generate that code. But I didn't try
> > very hard.

Yeah, it seems to really like emitting add and lea.

Inline asm obviously works:

003e     c09e:  48 81 fb 01 f0 ff ff    cmp    $0xfffffffffffff001,%rbx
0045     c0a5:  79 11                   jns    c0b8 <foo+0x58>
0047     c0a7:  48 89 df                mov    %rbx,%rdi
004a     c0aa:  e8 00 00 00 00          call   c0af <foo+0x4f>  c0ab: R_X86_64_PLT32    raw_spin_rq_unlock-0x4
...
0058     c0b8:  5b                      pop    %rbx
0059     c0b9:  5d                      pop    %rbp
005a     c0ba:  e9 00 00 00 00          jmp    c0bf <foo+0x5f>  c0bb: R_X86_64_PLT32    __x86_return_thunk-0x4

Just not sure its worth it at this point.

---
diff --git a/arch/x86/include/asm/cleanup.h b/arch/x86/include/asm/cleanup.h
new file mode 100644
index 000000000000..7cef49be8570
--- /dev/null
+++ b/arch/x86/include/asm/cleanup.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CLEANUP_H
+#define _ASM_X86_CLEANUP_H
+
+#define __GUARD_IS_ERR(_ptr) \
+	({ unsigned long _var = (__force unsigned long)(_ptr); \
+	   bool _s; \
+	   asm_inline volatile ("cmp %[val], %[var]" \
+				: "=@ccns" (_s) \
+				: [val] "i" (-MAX_ERRNO), \
+				  [var] "r" (_var)); \
+	   unlikely(_s); })
+
+#endif /* _ASM_X86_CLEANUP_H */
+
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 8675b7b4ad23..a59a88c95277 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -12,6 +12,7 @@ mandatory-y += bug.h
 mandatory-y += cacheflush.h
 mandatory-y += cfi.h
 mandatory-y += checksum.h
+mandatory-y += cleanup.h
 mandatory-y += compat.h
 mandatory-y += current.h
 mandatory-y += delay.h
diff --git a/include/asm-generic/cleanup.h b/include/asm-generic/cleanup.h
new file mode 100644
index 000000000000..616ae558638e
--- /dev/null
+++ b/include/asm-generic/cleanup.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_CLEANUP_H
+#define _ASM_GENERIC_CLEANUP_H
+
+#endif /* _ASM_GENERIC_CLEANUP_H */
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 18209e191973..00e5ef7aa314 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -6,6 +6,8 @@
 #include <linux/err.h>
 #include <linux/args.h>
 
+#include <asm/cleanup.h>
+
 /**
  * DOC: scope-based cleanup helpers
  *
@@ -312,9 +314,11 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
 static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 
+#ifndef __GUARD_IS_ERR
 #define __GUARD_IS_ERR(_ptr) \
 	({ unsigned long _rc = (__force unsigned long)(_ptr); \
 	   unlikely((_rc-1) >= -(MAX_ERRNO+1)); })
+#endif
 
 #define __DEFINE_GUARD_LOCK_PTR(_name, _exp) \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
