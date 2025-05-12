Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532C2550CA;
	Mon, 12 May 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076310; cv=none; b=nnD8/EUETZXU7j2FrQFGclS4lx4tUTKR8s+7ytq2MEv8JFbmGI/VTx60eJ4qBJuZuUG2piswaFwuPJSdpIXaNIIEJxthCwp0XuJb+BavbBLa943Uz4FxbYdpyNM0rzK1SkKL1sdll/toA0PyrSZ5kiSdjfG71MaG7zV2BcdTPS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076310; c=relaxed/simple;
	bh=YrFFTW2uoeyCJYK/IiPCjqT07YI/V1SpHoH5sAm3NlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhNaU5W11zlocC1hGbc2fAzjJ+7luEAYN+WpLSZpJEdwOCrQ3p0pnFyS6Dxm527qbG2XBrz1tzOY/epsU/+6xZuc+M2chPZVduB72XljUVlqtNDTSE+1+8tfoBE5/Qf3/p3/KeKwPMbgn7fZgEoLhNNVoam9qmkSGJEwj3Gbk28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Sa7rQeR5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sa7rQeR5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8CzbH5d57SrhSR667OO/7mNdtffIj/w4l1/Yw2mhnzo=; b=Sa7rQeR50MLRMDLLJ68qiRbq6g
	hOgrVVto0aZVR3rp5+jQuNjI5huAa1RXWRN9MoujO2+my1FgaU/YQNIHNJ+DP4ReUQGjpy8CzWQvn
	u389An4mmQB9SZt4kjM029dNZ+4lW8dC52qf3bHxJCA1Ye9wRyac1NzB05gwwQ18bM4ZoAbqhpssH
	edvtHDrck5Xu7xSNzrHvoGmbrJATskIZV1aGsb4sEKC9tmM+08EY+DXTV0vXM9pnxzyJvZeQwZHa2
	o4CkgemB8Hm4vfIDxZUaa+2IB65IIo4M1Z62dx2eOn5yOybTJcRQiAmqlpWVcGt0hWRLlC7//SIN/
	iqt6uqUg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uEYLx-0000000GoLm-3R1G;
	Mon, 12 May 2025 18:58:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 491F0300717; Mon, 12 May 2025 20:58:17 +0200 (CEST)
Date: Mon, 12 May 2025 20:58:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20250512185817.GA1808@noisy.programming.kicks-ass.net>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
 <20250507072145.3614298-2-dan.j.williams@intel.com>
 <20250507093224.GD4439@noisy.programming.kicks-ass.net>
 <681bce2193f38_1229d6294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20250508110043.GG4439@noisy.programming.kicks-ass.net>
 <681d8ce06c869_1229d6294e@dwillia2-xfh.jf.intel.com.notmuch>
 <20250509104028.GL4439@noisy.programming.kicks-ass.net>
 <681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch>
 <20250512105026.GP4439@noisy.programming.kicks-ass.net>
 <20250512182559.GB25891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512182559.GB25891@noisy.programming.kicks-ass.net>

On Mon, May 12, 2025 at 08:25:59PM +0200, Peter Zijlstra wrote:
> On Mon, May 12, 2025 at 12:50:26PM +0200, Peter Zijlstra wrote:
> 
> > +#define __GUARD_ERR(_ptr) \
> > +	({ long _rc = (__force unsigned long)(_ptr); \
> > +	   if (!_rc) { _rc = -EBUSY; } if (!IS_ERR_VALUE(_rc)) { _rc = 0; } \
> > +	   _rc; })
> > +
> 
> >  #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
> > -	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
> > +	DEFINE_CLASS(_name, _type, if (!__GUARD_ERR(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
> >  	DEFINE_CLASS_IS_GUARD(_name)
> 
> GCC is 'stupid' and this generates atrocious code. I'll play with it.

PRE:
    bf9e:       48 85 db                test   %rbx,%rbx
    bfa1:       74 1a                   je     bfbd <foo+0x5d>
    bfa3:       48 81 fb 00 f0 ff ff    cmp    $0xfffffffffffff000,%rbx
    bfaa:       77 11                   ja     bfbd <foo+0x5d>

POST:
    bf9e:       48 8d 43 ff             lea    -0x1(%rbx),%rax
    bfa2:       48 3d ff ef ff ff       cmp    $0xffffffffffffefff,%rax
    bfa8:       77 11                   ja     bfbb <foo+0x5b>

---
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -293,17 +293,18 @@ static inline class_##_name##_t class_##
 #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
 static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 
-#define __GUARD_ERR(_ptr) \
-	({ long _rc = (__force unsigned long)(_ptr); \
-	   if (!_rc) { _rc = -EBUSY; } if (!IS_ERR_VALUE(_rc)) { _rc = 0; } \
-	   _rc; })
+#define __GUARD_IS_ERR(_ptr) \
+	({ unsigned long _rc = (__force unsigned long)(_ptr); \
+	   unlikely((_rc-1) >= -MAX_ERRNO-1); })
 
 #define __DEFINE_GUARD_LOCK_PTR(_name, _exp) \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
 	{ void *_ptr = (void *)(__force unsigned long)*(_exp); \
 	  if (IS_ERR(_ptr)) { _ptr = NULL; } return _ptr; } \
 	static inline int class_##_name##_lock_err(class_##_name##_t *_T) \
-	{ return __GUARD_ERR(*(_exp)); }
+	{ long _rc = (__force unsigned long)*(_exp); \
+	  if (!_rc) { _rc = -EBUSY; } if (!IS_ERR_VALUE(_rc)) { _rc = 0; } \
+	  return _rc; }
 
 #define DEFINE_CLASS_IS_GUARD(_name) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, false); \
@@ -314,7 +315,7 @@ static __maybe_unused const bool class_#
 	__DEFINE_GUARD_LOCK_PTR(_name, _T)
 
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
-	DEFINE_CLASS(_name, _type, if (!__GUARD_ERR(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
+	DEFINE_CLASS(_name, _type, if (!__GUARD_IS_ERR(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	DEFINE_CLASS_IS_GUARD(_name)
 
 #define DEFINE_GUARD_COND_4(_name, _ext, _lock, _cond) \
@@ -406,7 +407,7 @@ typedef struct {							\
 									\
 static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 {									\
-	if (!__GUARD_ERR(_T->lock)) { _unlock; }			\
+	if (!__GUARD_IS_ERR(_T->lock)) { _unlock; }			\
 }									\
 									\
 __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
