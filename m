Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310EA136988;
	Mon, 12 May 2025 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047041; cv=none; b=DkcftFeblnkgolpV6jGYAraR3clf673EO3cm+/6kdPSGaOBaH6BzRcdeQdL/BmIXyAS/5jTFRFWFaNnsFlxYZwxNKqgMOVfXaeeLvEseEpQOIr5m0JVVSa64ozB5ryksyhE/6koOw9/qVNfVaQKj2BN+II2z4Br+P+OKmji1wAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047041; c=relaxed/simple;
	bh=IkzbvfjzDYWbphpyW2IDrgtnafGpDBdltDp9JTpA7xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnNTqccxAZTrLVpxqQ8Y2ymeTAcVGMAI8uKVOk2r1VDNZLoj37Lj1WcyIt94DbWApk8k9w/dUrOmhnCYBr8v9r9UnEqTEDHlvJfFypsN6g/JqwQPzChw1wOfoPLX28v0r140DFmRTF6NNlmEc1uBxAo67Yo/u2FpgZrdVGZsoRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ux2VZqQo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ux2VZqQo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e0HZJ9wUeu2+Lw+/RFIiPN+iuLxrwz61cA7t0PY+IAI=; b=Ux2VZqQo4PMc0qCUjTeDNvYvFd
	UbXMIASVLYlSTpfcuZHoBoHjkSk7VH1EQUoBLLMKIDPc6CFm++XZzLSs5aOT87NNvohVLSJYLJkcU
	fOr605pcjlAYx+nZ57U3V3JrzOI+qpxflIHK3pmmAc/sbilg5twhsAXkpYsuRl3KxQXWI35q9e6Cz
	og6k4D2FFIr44hYuXZ/lev1B49hi67tMHVKHtGHgakHr/b1RTiPcl7gNnjHbKkJtPfd7PsR6mjSXB
	fiuEosW7rsU3MYiTwumY2Tq2A3Xgu7ECkClxG5GYq23t/W79DLME0EFhEIvkEoHDpxgzCpKG4rF7R
	UnQG9qog==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uEQjr-0000000GkMU-0Rcm;
	Mon, 12 May 2025 10:50:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 81290300717; Mon, 12 May 2025 12:50:26 +0200 (CEST)
Date: Mon, 12 May 2025 12:50:26 +0200
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
Message-ID: <20250512105026.GP4439@noisy.programming.kicks-ass.net>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
 <20250507072145.3614298-2-dan.j.williams@intel.com>
 <20250507093224.GD4439@noisy.programming.kicks-ass.net>
 <681bce2193f38_1229d6294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20250508110043.GG4439@noisy.programming.kicks-ass.net>
 <681d8ce06c869_1229d6294e@dwillia2-xfh.jf.intel.com.notmuch>
 <20250509104028.GL4439@noisy.programming.kicks-ass.net>
 <681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch>

On Fri, May 09, 2025 at 06:11:49PM -0700, dan.j.williams@intel.com wrote:

> ---
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 6b0ca400b393..e5d2171c9a48 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1395,7 +1395,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  	int rc;
>  
>  	ACQUIRE(mutex_intr, lock)(&mds->poison.poison_lock);
> -	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> +	if ((rc = ACQUIRE_ERR(mutex_intr, lock)))
>  		return rc;
>  
>  	po = mds->poison.list_out;
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index 17d4655a6b73..b379ff445179 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -335,7 +342,7 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
>  	CLASS(_name, _var)
>  
>  #define ACQUIRE_ERR(_name, _var) \
> -	({ long _rc = PTR_ERR(__guard_ptr(_name)(_var)); \
> +	({ long _rc = PTR_ERR(__guard_ptr(_name)(&(_var))); \
>  	   if (!_rc) _rc = -EBUSY; \
>  	   if (!IS_ERR_VALUE(_rc)) _rc = 0; \
>  	   _rc; })
> 

No strong feelings about this. I see arguments either way.

> ---
> 
> Also, I needed the following to get this to compile:

Ah, I didn't get beyond nvim/clangd not complaining about things :-)

> ---
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index 17d4655a6b73..052bbad6ac68 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -305,8 +305,15 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
>  	__DEFINE_CLASS_IS_CONDITIONAL(_name, true); \
>  	__DEFINE_GUARD_LOCK_PTR(_name, _T)
>  
> +/*
> + * For guard with a potential percpu lock, the address space needs to be
> + * cast away.
> + */
> +#define IS_ERR_OR_NULL_ANY(x) \
> +IS_ERR_OR_NULL((const void *)(__force const unsigned long)(x))
> +
>  #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
> -	DEFINE_CLASS(_name, _type, if (!IS_ERR_OR_NULL(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
> +	DEFINE_CLASS(_name, _type, if (!IS_ERR_OR_NULL_ANY(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
>  	DEFINE_CLASS_IS_GUARD(_name)
>  
>  #define DEFINE_GUARD_COND_4(_name, _ext, _lock, _cond) \
> @@ -401,7 +408,7 @@ typedef struct {							\
>  									\
>  static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
>  {									\
> -	if (!IS_ERR_OR_NULL(_T->lock)) { _unlock; }			\
> +	if (!IS_ERR_OR_NULL_ANY(_T->lock)) { _unlock; }			\
>  }									\
>  									\
>  __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)

So looking at this I realized I might have inadvertly broken
scoped_guard() and scoped_cond_guard(), both rely on !__guard_ptr() for
the failure case, and this is no longer true.

The below seems to cover things. I even did a simple compile :-)

---

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d72764056ce6..8a52e337dd0f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1394,8 +1394,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int nr_records = 0;
 	int rc;
 
-	rc = mutex_lock_interruptible(&mds->poison.lock);
-	if (rc)
+	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
+	if ((rc = ACQUIRE_ERR(mutex_intr, lock)))
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
+	mutex_init(&mds->poison.mutex);
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, "CXL");
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 3ec6b906371b..1dfd361ed295 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -257,7 +257,7 @@ struct cxl_poison_state {
 	u32 max_errors;
 	DECLARE_BITMAP(enabled_cmds, CXL_POISON_ENABLED_MAX);
 	struct cxl_mbox_poison_out *list_out;
-	struct mutex lock;  /* Protect reads of poison list */
+	struct mutex mutex;  /* Protect reads of poison list */
 };
 
 /*
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 7093e1d08af0..a20d70e563e1 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -3,6 +3,8 @@
 #define _LINUX_CLEANUP_H
 
 #include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/args.h>
 
 /**
  * DOC: scope-based cleanup helpers
@@ -310,9 +312,17 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
 static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 
+#define __GUARD_ERR(_ptr) \
+	({ long _rc = (__force unsigned long)(_ptr); \
+	   if (!_rc) { _rc = -EBUSY; } if (!IS_ERR_VALUE(_rc)) { _rc = 0; } \
+	   _rc; })
+
 #define __DEFINE_GUARD_LOCK_PTR(_name, _exp) \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
-	{ return (void *)(__force unsigned long)*(_exp); }
+	{ void *_ptr = (void *)(__force unsigned long)*(_exp); \
+	  if (IS_ERR(_ptr)) { _ptr = NULL; } return _ptr; } \
+	static inline int class_##_name##_lock_err(class_##_name##_t *_T) \
+	{ return __GUARD_ERR(*(_exp)); }
 
 #define DEFINE_CLASS_IS_GUARD(_name) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, false); \
@@ -323,23 +333,37 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 	__DEFINE_GUARD_LOCK_PTR(_name, _T)
 
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
-	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
+	DEFINE_CLASS(_name, _type, if (!__GUARD_ERR(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	DEFINE_CLASS_IS_GUARD(_name)
 
-#define DEFINE_GUARD_COND(_name, _ext, _condlock) \
+#define DEFINE_GUARD_COND_4(_name, _ext, _lock, _cond) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true); \
 	EXTEND_CLASS(_name, _ext, \
-		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
+		     ({ void *_t = _T; int _RET = (_lock); if (_T && !(_cond)) _t = ERR_PTR(_RET); _t; }), \
 		     class_##_name##_t _T) \
 	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
-	{ return class_##_name##_lock_ptr(_T); }
+	{ return class_##_name##_lock_ptr(_T); } \
+	static inline int class_##_name##_ext##_lock_err(class_##_name##_t *_T) \
+	{ return class_##_name##_lock_err(_T); }
+
+/*
+ * Default binary condition; success on 'true'.
+ */
+#define DEFINE_GUARD_COND_3(_name, _ext, _lock) \
+	DEFINE_GUARD_COND_4(_name, _ext, _lock, _RET)
+
+#define DEFINE_GUARD_COND(X...) CONCATENATE(DEFINE_GUARD_COND_, COUNT_ARGS(X))(X)
 
 #define guard(_name) \
 	CLASS(_name, __UNIQUE_ID(guard))
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
+#define __guard_err(_name) class_##_name##_lock_err
 #define __is_cond_ptr(_name) class_##_name##_is_conditional
 
+#define ACQUIRE(_name, _var)     CLASS(_name, _var)
+#define ACQUIRE_ERR(_name, _var) __guard_err(_name)(&(_var))
+
 /*
  * Helper macro for scoped_guard().
  *
@@ -401,7 +425,7 @@ typedef struct {							\
 									\
 static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 {									\
-	if (_T->lock) { _unlock; }					\
+	if (!__GUARD_ERR(_T->lock)) { _unlock; }			\
 }									\
 									\
 __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
@@ -433,15 +457,22 @@ __DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
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
-	{ return class_##_name##_lock_ptr(_T); }
+	{ return class_##_name##_lock_ptr(_T); } \
+	static inline int class_##_name##_ext##_lock_err(class_##_name##_t *_T) \
+	{ return class_##_name##_lock_err(_T); }
+
+#define DEFINE_LOCK_GUARD_1_COND_3(_name, _ext, _lock) \
+	DEFINE_LOCK_GUARD_1_COND_4(_name, _ext, _lock, _RET);
 
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
