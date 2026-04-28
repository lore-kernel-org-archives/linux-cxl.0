Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28809378821;
	Tue, 28 Apr 2026 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777403106; cv=none; b=buLRm8+n8QFsVoD65OJG4pdGlE11EnRaB4b4D0NsIzEd5UghHlCU+Rys3OKgIowhGFIPNtyGh6NSla5wha7dxfXrpqJbxnLMGtidwx3LoWb/U8dVgm0ZzYJ14b0si+Tg1TG9+45V2mgLLeLpCSpJrWFYj5119GOYTvZDm9dRnRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777403106; c=relaxed/simple;
	bh=yiFTRDNTxjDongUjUMQAqRtHRw/8PMmkM7u5vj7hnwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSwkXT9Db1fZZAyPUEznr5m5rsR50U6FcRwHlR3czSYRAH8RcQTSxfCoslYLL++K2oMypYOGd2YFonPR1pZ+dRQPHrGGsxNWFDobSuWHhyF7km45ZMq/nSbvIegONGT8Kv9JJWccENgYzTNFS5iwzm6freDoVZeIRU/Rx5zx8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADE/Oa7W; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADE/Oa7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777403100; x=1808939100;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yiFTRDNTxjDongUjUMQAqRtHRw/8PMmkM7u5vj7hnwk=;
  b=ADE/Oa7WrJ5wojj6akAb760cygyK3iFEGvjMVXPH/ibU4B7ME8sucISK
   Eg3FqJcS1Lg4Rd3A27B/ZJFJHoPf6wWmTZNO+m4IUf6WIQjXu7xw5xQ5L
   V6MKRJFN1zdC4BI3phgOiBBLCN9AEJnIFpLU+TZfl5OtHh1PyI/Yj3he+
   l2UEBhM+2WTUKFx3QJJSXJ6PO9VDkHOcOimNlD+QeAdXeBl4WPosFZVW5
   uTkyPJtpwNRRJgce3rkdu/nuq44uMlJiMZE6GJ8TNLo51NsR6F6iASnFA
   boH1jv6MuoMqhJnPzvcf/JxP5W/+aYmMEe2Kc4s8CoNkkSJiFfDssa7WU
   Q==;
X-CSE-ConnectionGUID: fUY0ByjPS1qOyuYINuM86A==
X-CSE-MsgGUID: cIirnowmS2S3zQLdrekFWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89020779"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="89020779"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 12:04:58 -0700
X-CSE-ConnectionGUID: zw1RFg9JSgi7qRpaHeg1GQ==
X-CSE-MsgGUID: FVGOj2tDR4mrjEK56Se9Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="238370433"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.108.229]) ([10.125.108.229])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 12:04:57 -0700
Message-ID: <4a20f390-a49d-4a9f-911f-21c36449b990@intel.com>
Date: Tue, 28 Apr 2026 12:04:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] cxl/region: Fix race conditions in cxl region
 unregistration.
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, Robert Richter <rrichter@amd.com>,
 Li Ming <ming.li@zohomail.com>, Gregory Price <gourry@gourry.net>,
 Ben Widawsky <bwidawsk@kernel.org>, Dave Tian <daveti@purdue.edu>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260427032010.916681-2-iam@sung-woo.kim>
 <5b46d2ca-7821-4245-92fc-7169ea7435ae@intel.com>
 <CAJNyHpKMMwGnf7+2yzNnSbzozm2ROzfWmWg4xj8gROha+ncQeA@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJNyHpKMMwGnf7+2yzNnSbzozm2ROzfWmWg4xj8gROha+ncQeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/27/26 10:42 PM, Sungwoo Kim wrote:
> On Mon, Apr 27, 2026 at 1:42 PM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>
>>
>> On 4/26/26 8:20 PM, Sungwoo Kim wrote:
>>> This version mainly addresses Dave's comments and meaningful issues reported by Sashiko AI[1].
>>>
>>> Overview
>>> ========
>>> This patch series fixes race conditions in cxl region unregistration.
>>>
>>> devm_release_action() should be called once, otherwise, it warns about
>>> the second call. However, the current implementation has a race condition
>>> that allows multiple calls to devm_release_action(). The details are in
>>> each patch.
>>>
>>> To fix these, the first patch adds a new function that guarantees that
>>> devm_release_action() is called only once.
>>> Using this function, the second patch subsitutes the current use of
>>> devm_release_action() in cxl region with the new function.
>>>
>>> Change in v3
>>> ============
>>> Addressed Dave's comments:
>>> - Split and made this in a patch series.
>>> - Enhanced a commit log explaining why a workqueue is used in the first patch.
>>> - Added a context on how these issues were found and what impact was observed and how that effects a user in the second patch.
>>> Sashiko AI review fixes:
>>> - Fixed construct_region() as it also can race.
>>> - Used a driver's wq instead of system wq so unbinding can drain a work.
>>
>> A few issues Sashiko raised with the v3.
>> https://sashiko.dev/#/patchset/20260427032010.916681-2-iam%40sung-woo.kim
> 
> A Sashiko's reasoning makes sense to me. In the middle of
> construct_region(), users can perform a sysfs write, which then calls
> unregister_region().
> unregister_region() must not be called before construct_region() has
> completed, since it calls device_del() and put_device().
> 
> This isn't introduced by this patch, but I can fix it in v4.
> 
> An enable/disable flag to allow sysfs write might fix this, like:
> 
> static struct cxl_region *construct_region(...)
> {
> ... // when a construction is done
>   set_bit(CXL_REGION_F_ENABLE_SYSFS);
>   return cxlr;
> }
> 
> This prevents a sysfs write before it's done:
> 
> static ssize_t delete_region_store(...)
> {
>   if (!test_bit(CXL_REGION_F_ENABLE_SYSFS)) {
>     return -EBUSY;
>   }
> ...
> }
> 
> Would there be a better solution? I'd like to ask for comments on this.
> This patch series already introduces two new flags, and I'm concerned
> about adding another.

Sungwoo,
I looked at the sachiko raised issues and looked at the current patches. I threw the sachiko objections and the current patches at Claude and it says the workqueue change made this more complicated and proposed this solution. Seems reasonable. What do you think?

---

    Race 1: Concurrent delete_region_store() calls
    ===============================================
    CPU 0                                  CPU 1
    delete_region_store()                  delete_region_store()
      cxl_find_region_by_name()              cxl_find_region_by_name()
      devm_release_action()                  devm_release_action()
        unregister_region()                    WARN_ON(-ENOENT)
    
    The second call fails because the devm action was already removed.
    
    Race 2: Concurrent delete and driver unbind
    ============================================
    CPU 0                                  CPU 1
    delete_region_store()                  driver unbind
      cxl_find_region_by_name()              devres_release_all()
      devm_release_action()                    unregister_region()
        unregister_region()                    // cleanup done
        // cleanup done again!
                                             WARN_ON(-ENOENT)
    
    Race 3: Use-after-free during construction
    ===========================================
    CPU 0: __construct_region()            CPU 1: delete_region_store()
    device_add(&cxlr->dev)
      // Region visible in sysfs!
                                           cxl_find_region_by_name()
                                             // SUCCESS!
    __construct_region(cxlr)
      p = &cxlr->params
      // p->interleave_ways still 0
                                           unregister_region(cxlr)
                                             device_del()
                                             for (i = 0; i < 0; i++)
                                               // LOOP SKIPPED!
                                             put_device(&cxlr->dev)
                                             // refcount -> 0
                                           // cxlr FREED!
    
      p->interleave_ways = ctx->...        // USE-AFTER-FREE!
      p->state = INTERLEAVE_ACTIVE         // USE-AFTER-FREE!
    
    The Solution
    ============
    
    1. Make unregister_region() idempotent using CXL_REGION_F_UNREGISTER flag
       Multiple concurrent calls will have one do the cleanup and others
       return early safely.
    
    2. Use synchronous devm_remove_action_nowarn() instead of devm_release_action()
       - Call unregister_region() first (idempotent cleanup)
       - Then remove devm action with _nowarn variant
       - -ENOENT is benign in all race scenarios:
         * devres_release_all() already handled it
         * Driver unbind/rebind race (old action gone, new devres list)
    
    3. Protect params read in unregister_region() with lock
       Use scoped_guard(rwsem_read) to safely read interleave_ways even
       during concurrent construction. If state < INTERLEAVE_ACTIVE, the
       region is still initializing and ways=0 is correct.
    
    4. Add memory barriers for state transitions
       Use smp_store_release() in __construct_region() and smp_load_acquire()
       in unregister_region() to ensure proper ordering of initialization.
    
    5. Hold extra reference during construct_region()
       Prevents premature freeing if unregister races during initialization.
    
    6. Check unregister flag in __construct_region()
       Abort construction early if delete_region_store() raced after
       device_add() but before acquiring the write lock.
    
    This approach is simpler and more correct than async workers because:
    - Relies on fundamental kernel primitives (idempotency + locks)
    - No TOCTOU races with driver binding state
    - Fewer lines of code
    - Handles all race scenarios correctly
    
    Race Scenario Analysis:
    
    | Scenario                  | Outcome                              |
    |---------------------------|--------------------------------------|
    | Normal delete             | Cleanup done, action removed         |
    | Concurrent deletes        | One cleans up, others return early   |
    | Delete + driver unbind    | One cleans up, other gets -ENOENT    |
    | Delete + unbind/rebind    | Old action handled, -ENOENT benign   |
    | Delete during construct   | Extra ref prevents UAF, lock protects|
    
---

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..8474756913e6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2541,16 +2541,45 @@ static void unregister_region(void *_cxlr)
 {
 	struct cxl_region *cxlr = _cxlr;
 	struct cxl_region_params *p = &cxlr->params;
-	int i;
+	int i, ways;
+
+	/*
+	 * Idempotency: prevent multiple concurrent calls to unregister_region().
+	 * This can happen if user calls delete_region_store() while driver
+	 * unbind triggers devres_release_all() concurrently.
+	 */
+	if (test_and_set_bit(CXL_REGION_F_UNREGISTER, &cxlr->flags))
+		return;
 
 	device_del(&cxlr->dev);
 
 	/*
-	 * Now that region sysfs is shutdown, the parameter block is now
-	 * read-only, so no need to hold the region rwsem to access the
-	 * region parameters.
+	 * Even though sysfs is shutdown, the region may still be initializing
+	 * if construct_region() is running concurrently. We must safely read
+	 * interleave_ways under lock to avoid reading uninitialized values.
+	 *
+	 * Use a read lock (not write) to allow concurrent operations if needed.
+	 * Read the ways count under lock, then release before the loop to
+	 * minimize lock hold time.
+	 *
+	 * Memory ordering: use smp_load_acquire() to ensure we see the fully
+	 * initialized value of interleave_ways if state >= INTERLEAVE_ACTIVE.
 	 */
-	for (i = 0; i < p->interleave_ways; i++)
+	scoped_guard(rwsem_read, &cxl_rwsem.region) {
+		/*
+		 * Pairs with smp_store_release() in __construct_region().
+		 * Ensures if we see state >= INTERLEAVE_ACTIVE, we also see
+		 * the initialized interleave_ways value.
+		 */
+		enum cxl_config_state state = smp_load_acquire(&p->state);
+
+		if (state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+			ways = READ_ONCE(p->interleave_ways);
+		else
+			ways = 0; /* Still initializing, nothing to detach */
+	}
+
+	for (i = 0; i < ways; i++)
 		detach_target(cxlr, i);
 
 	cxlr->hpa_range = DEFINE_RANGE(0, -1);
@@ -2838,14 +2867,48 @@ static ssize_t delete_region_store(struct device *dev,
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 	struct cxl_port *port = to_cxl_port(dev->parent);
 	struct cxl_region *cxlr;
+	int rc;
 
 	cxlr = cxl_find_region_by_name(cxlrd, buf);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
+	/*
+	 * Call unregister_region() first to do the cleanup. This is
+	 * idempotent (CXL_REGION_F_UNREGISTER flag), so if
+	 * devres_release_all() calls it concurrently, one will do the
+	 * work and the other will return early.
+	 */
+	unregister_region(cxlr);
+
+	/*
+	 * Now remove the devm action to prevent devres_release_all()
+	 * from calling unregister_region() again during driver unbind.
+	 *
+	 * Three possible outcomes:
+	 *
+	 * 1. Success: We removed the action before driver unbind.
+	 *    Driver unbind won't call unregister_region().
+	 *
+	 * 2. -ENOENT: devres_release_all() already removed the action
+	 *    and called unregister_region() (which returned early due
+	 *    to F_UNREGISTER flag). This is benign.
+	 *
+	 * 3. -ENOENT: Driver was unbound and rebound between
+	 *    unregister_region() above and here. The old action was
+	 *    already handled by the old unbind. The new binding has
+	 *    no action for this region. This is benign.
+	 *
+	 * Use _nowarn variant since -ENOENT is expected and benign.
+	 * The devres_lock serializes access, so we can't corrupt the
+	 * devres list.
+	 */
+	rc = devm_remove_action_nowarn(port->uport_dev, unregister_region, cxlr);
+	if (rc && rc != -ENOENT)
+		dev_warn(&cxlr->dev,
+			 "Unexpected error removing devm action: %d\n", rc);
+
 	put_device(&cxlr->dev);
-
 	return len;
 }
 DEVICE_ATTR_WO(delete_region);
@@ -3644,6 +3707,16 @@ static int __construct_region(struct cxl_region *cxlr,
 		return -EBUSY;
 	}
 
+	/*
+	 * Check if region is being unregistered concurrently. This can happen
+	 * if user triggers delete_region_store() right after device_add() but
+	 * before we acquire the write lock above.
+	 */
+	if (test_bit(CXL_REGION_F_UNREGISTER, &cxlr->flags)) {
+		dev_dbg(&cxlr->dev, "Region unregister in progress, aborting construction\n");
+		return -EBUSY;
+	}
+
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
 	cxlr->hpa_range = *hpa_range;
 
@@ -3686,7 +3759,16 @@ static int __construct_region(struct cxl_region *cxlr,
 	p->res = res;
 	p->interleave_ways = ctx->interleave_ways;
 	p->interleave_granularity = ctx->interleave_granularity;
-	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
+
+	/*
+	 * Use smp_store_release() to ensure all initialization above is
+	 * visible before state becomes INTERLEAVE_ACTIVE. This pairs with
+	 * smp_load_acquire() in unregister_region().
+	 *
+	 * This ensures that if unregister_region() sees state >=
+	 * INTERLEAVE_ACTIVE, it will also see the initialized interleave_ways.
+	 */
+	smp_store_release(&p->state, CXL_CONFIG_INTERLEAVE_ACTIVE);
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
 	if (rc)
@@ -3728,12 +3810,31 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
+	/*
+	 * Hold an extra reference during initialization to prevent
+	 * unregister_region() from freeing the object if delete_region_store()
+	 * races with __construct_region(). The device_initialize() in
+	 * cxl_region_alloc() set refcount=1, and device_add() above made it
+	 * visible, so a concurrent unregister could drop that reference while
+	 * we're still initializing.
+	 */
+	get_device(&cxlr->dev);
+
 	rc = __construct_region(cxlr, ctx);
 	if (rc) {
-		devm_release_action(port->uport_dev, unregister_region, cxlr);
+		/*
+		 * Construction failed. Unregister the partially initialized
+		 * region and remove the devm action. Both are safe to call
+		 * due to idempotency and proper locking.
+		 */
+		unregister_region(cxlr);
+		devm_remove_action_nowarn(port->uport_dev, unregister_region, cxlr);
+
+		put_device(&cxlr->dev); /* Drop construction reference */
 		return ERR_PTR(rc);
 	}
 
+	put_device(&cxlr->dev); /* Drop construction reference */
 	return cxlr;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1297594beaec..81952f0763e1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -447,6 +447,13 @@ struct cxl_region_params {
  */
 #define CXL_REGION_F_NORMALIZED_ADDRESSING 3
 
+/*
+ * Indicate that this region is being unregistered. Used to make
+ * unregister_region() idempotent and prevent race conditions between
+ * delete_region_store() and devres_release_all().
+ */
+#define CXL_REGION_F_UNREGISTER 4
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
