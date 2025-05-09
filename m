Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7E17BCE;
	Fri,  9 May 2025 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787244; cv=none; b=kwPs2JBsEOI+ATrBTy98lFcJoQc5q/8Gy+/Xp+bCHjQag8ya5tGU+7L53oR5XXLHvb+qvppJd0M7cA2UQsPSVBHcePDcZIpG/mzoroUV10//KzPxb0tRNefmBDy4nTkZqPxVZ3rd61NWRzsvwyMklHesTXGzk+yaBB3tSG22+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787244; c=relaxed/simple;
	bh=ADDyJAfTgFQ8JBdm1vgOn3ThK0IQ5MCWNQqVDkR/P7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjhkGyb59W2WjhtkgmqngknlWyDqTvlnPdBsWaYNQsh6c5CnBDYfw26qAdEW7ijTH6gzmzHFqxZCty1KOsrPirhxqP3CXkD4nGRsIhqINCZ3YDP/lRoZfkLb0W2DVKnDep2BvSjmfUl0lKn/+9XgBbQGmAulWsbEykY7lQLlMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gMGdWk99; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gMGdWk99"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gEhSIc1pXgT8q5ymNeP5CG34TnvHdUkZKckbTnD4v1M=; b=gMGdWk99iVA2oebREYRtzEJAeS
	i0kVA1aUJFqFZt/vbuh0WAo86aVcbI8R+tfxRA6/16eUvpqDSgaE9r80ckESCL76S+I12VHNVlNXI
	We3YgxZKaH2xwrMLtV/83IHM34dTxd8yVp8Ol9yLwgCyhhGsD3zytksp1VpegGHD8fTxdp19gNYOc
	TdvKWmxHWUfwG7y6yGTnRRgiuadNWGsGbeOq6C4X5KhFITfM9PzzKWCxZmzgE9BLWAwBazVmTG+Pk
	lPxFM3Dh4/FJBNmKeURB+ShLhHApCyp6QSvARrKmFAKPQf0wYQW5d4Iv0HlLgtYEUlMnWIiIN+Iby
	j8lufGhA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uDL9Z-0000000GFuH-2xoG;
	Fri, 09 May 2025 10:40:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C84C6300781; Fri,  9 May 2025 12:40:28 +0200 (CEST)
Date: Fri, 9 May 2025 12:40:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
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
Message-ID: <20250509104028.GL4439@noisy.programming.kicks-ass.net>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
 <20250507072145.3614298-2-dan.j.williams@intel.com>
 <20250507093224.GD4439@noisy.programming.kicks-ass.net>
 <681bce2193f38_1229d6294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20250508110043.GG4439@noisy.programming.kicks-ass.net>
 <681d8ce06c869_1229d6294e@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681d8ce06c869_1229d6294e@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, May 08, 2025 at 10:04:32PM -0700, Dan Williams wrote:
> Peter Zijlstra wrote:
> [..]
> > > So the proposal is, if you know what you are doing, or have a need to
> > > switch back and forth between scope-based and explicit unlock for a give
> > > lock, use the base primitives. If instead you want to fully convert to
> > > scope-based lock management (excise all explicit unlock() calls) *and*
> > > you want the compiler to validate the conversion, switch to the _acquire
> > > parallel universe.
> > 
> > As with all refactoring ever, the rename trick always works. But I don't
> > think that warrants building a parallel infrastructure just for that.
> > 
> > Specifically, it very much does not disallow calling mutex_unlock() on
> > your new member. So all you get is some compiler help during refactor,
> > and again, just rename the lock member already.
> > 
> > Also, if we ever actually get LLVM's Thread Safety Analysis working,
> > that will help us with all these problems:
> > 
> >   https://lore.kernel.org/all/20250304092417.2873893-1-elver@google.com/
> 
> That looks lovely.
> 
> > But the compiler needs a little more work go grok C :-)
> 
> Ok, here is a last shot that incorporates all the feedback:
> 
> 1/ Conceptually no need for a new CLASS() save for the fact that
>    __guard_ptr() returns NULL on failure, not an ERR_PTR().
> 
> 2/ The rename trick is not true type safety, especially if it leads to
>    parallel universe of primitives, but it is a useful trick.
> 
> 3/ "IS_ERR(__guard_ptr(mutex_intr)(lock))" is a mouthful, would be nice
>    to have something more succint while maintaining some safety.
> 
> That leads me to a scheme like the following:
> 
>     DEFINE_GUARD_ERR(mutex, _intr, mutex_lock_interruptible(_T))
>     ...
>     ACQUIRE(mutex_intr, lock)(&obj->lock);
>     if (IS_ERR(lock))
>        return PTR_ERR(lock);

Urgh.. can you live with something like this?

---
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d72764056ce6..6b0ca400b393 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1394,8 +1394,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int nr_records = 0;
 	int rc;
 
-	rc = mutex_lock_interruptible(&mds->poison.lock);
-	if (rc)
+	ACQUIRE(mutex_intr, lock)(&mds->poison.poison_lock);
+	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
 		return rc;
 
 	po = mds->poison.list_out;
@@ -1430,7 +1430,6 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		}
 	} while (po->flags & CXL_POISON_FLAG_MORE);
 
-	mutex_unlock(&mds->poison.lock);
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, "CXL");
@@ -1466,7 +1465,7 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
 		return rc;
 	}
 
-	mutex_init(&mds->poison.lock);
+	mutex_init(&mds->poison.poison_lock);
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, "CXL");
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 3ec6b906371b..85a160c778ae 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -257,7 +257,7 @@ struct cxl_poison_state {
 	u32 max_errors;
 	DECLARE_BITMAP(enabled_cmds, CXL_POISON_ENABLED_MAX);
 	struct cxl_mbox_poison_out *list_out;
-	struct mutex lock;  /* Protect reads of poison list */
+	struct mutex poison_lock;  /* Protect reads of poison list */
 };
 
 /*
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 7093e1d08af0..c0439fd63915 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -3,6 +3,8 @@
 #define _LINUX_CLEANUP_H
 
 #include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/args.h>
 
 /**
  * DOC: scope-based cleanup helpers
@@ -323,23 +325,40 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 	__DEFINE_GUARD_LOCK_PTR(_name, _T)
 
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
-	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
+	DEFINE_CLASS(_name, _type, if (!IS_ERR_OR_NULL(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	DEFINE_CLASS_IS_GUARD(_name)
 
-#define DEFINE_GUARD_COND(_name, _ext, _condlock) \
+#define DEFINE_GUARD_COND_4(_name, _ext, _lock, _cond) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true); \
 	EXTEND_CLASS(_name, _ext, \
-		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
+		     ({ void *_t = _T; int _RET = (_lock); if (_T && !(_cond)) _t = ERR_PTR(_RET); _t; }), \
 		     class_##_name##_t _T) \
 	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
 	{ return class_##_name##_lock_ptr(_T); }
 
+/*
+ * Default binary condition; success on 'true'.
+ */
+#define DEFINE_GUARD_COND_3(_name, _ext, _lock) \
+	DEFINE_GUARD_COND_4(_name, _ext, _lock, _RET)
+
+#define DEFINE_GUARD_COND(X...) CONCATENATE(DEFINE_GUARD_COND_, COUNT_ARGS(X))(X)
+
 #define guard(_name) \
 	CLASS(_name, __UNIQUE_ID(guard))
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
 #define __is_cond_ptr(_name) class_##_name##_is_conditional
 
+#define ACQUIRE(_name, _var) \
+	CLASS(_name, _var)
+
+#define ACQUIRE_ERR(_name, _var) \
+	({ long _rc = PTR_ERR(__guard_ptr(_name)(_var)); \
+	   if (!_rc) _rc = -EBUSY; \
+	   if (!IS_ERR_VALUE(_rc)) _rc = 0; \
+	   _rc; })
+
 /*
  * Helper macro for scoped_guard().
  *
@@ -401,7 +420,7 @@ typedef struct {							\
 									\
 static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 {									\
-	if (_T->lock) { _unlock; }					\
+	if (!IS_ERR_OR_NULL(_T->lock)) { _unlock; }			\
 }									\
 									\
 __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
@@ -433,15 +452,20 @@ __DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
 __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_0(_name, _lock)
 
-#define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
+#define DEFINE_LOCK_GUARD_1_COND_4(_name, _ext, _lock, _cond)		\
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true);		\
 	EXTEND_CLASS(_name, _ext,					\
 		     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
-		        if (_T->lock && !(_condlock)) _T->lock = NULL;	\
+		        int _RET = (_lock);                             \
+		        if (_T->lock && !(_cond)) _T->lock = ERR_PTR(_RET);\
 			_t; }),						\
 		     typeof_member(class_##_name##_t, lock) l)		\
 	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
 	{ return class_##_name##_lock_ptr(_T); }
 
+#define DEFINE_LOCK_GUARD_1_COND_3(_name, _ext, _lock) \
+	DEFINE_LOCK_GUARD_1_COND_4(_name, _ext, _lock, _RET);
+
+#define DEFINE_LOCK_GUARD_1_COND(X...) CONCATENATE(DEFINE_LOCK_GUARD_1_COND_, COUNT_ARGS(X))(X)
 
 #endif /* _LINUX_CLEANUP_H */
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 2143d05116be..232fdde82bbb 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -200,7 +200,7 @@ extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
 DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
 DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
-DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
+DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T), _RET == 0)
 
 extern unsigned long mutex_get_owner(struct mutex *lock);
 
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index c8b543d428b0..c810deb88d13 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -240,7 +240,7 @@ extern void up_write(struct rw_semaphore *sem);
 
 DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
 DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
-DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T) == 0)
+DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T), _RET == 0)
 
 DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
 DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
