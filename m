Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A7974C14;
	Tue, 28 Apr 2026 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415604; cv=none; b=NBsh7bobICI02z02RcUfyLLPxMrkJ3Pm7nlwA8XBFSj2y12AR7iQapovtpj5m/DSH3jBi1oWuGowfOmOgvwIVDBmLD0EhVU5/gUmDnTnG/T0KDPvvmEGyNmbOeb6sfaz8c0GToQz6wIkNz7ytdFxlQbKpF5qD7RRHWgNR9wWW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415604; c=relaxed/simple;
	bh=rSU5rSuFO3Vk7iR4GzofEkwaqRiAvZ+HFS7Nj5dkaLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrNTp1PtRWawLaJAspZpoA3IdqNqRTROr5DWVBi/EAcxmYVC+hqnKsGYkkTam5UYuRU34l2nclZeqJlPdZdrAviK/xRwSMHj7FbLXoWa1Tq+CH9PIO52Vd5zLYLuCpCHY3ilX2YeVP31Xymcb/hvna/bepz58Qia6W90FoR3OyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuypZdK9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuypZdK9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777415603; x=1808951603;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rSU5rSuFO3Vk7iR4GzofEkwaqRiAvZ+HFS7Nj5dkaLI=;
  b=TuypZdK9EjBVKEAmxTfoNxWi14u6uYOCE6uP6rYP3KFfrS7R5Bcrb4Dk
   4OO1T/74oqUzFmSXF0fANQW+7Oc3xFokjQp6PThpaLscCS4LRVL5gKlua
   /L9tYeZg6nl9zU1smt+HvR2Fsz1JDyxMyyJwKJlFV6BnWTzPX4tcYY7bI
   ffITbmQ03OCMcvrB7FVkz8K4HL0zuCk/u1ko3q42tX6vorICeLtJuJEkG
   94S9JyD/BIuGWchJ0MNikSdWzPHw+snsqmUDQSzevlzDGKYm8u0gl55hp
   go8j5TyIY0qJpLb6nzlXNJPCHWBpbG9Mho6+bsGMJQk9rb8ri18X3Ysex
   w==;
X-CSE-ConnectionGUID: yqtcgxWiTqKBjSzf1NkwBw==
X-CSE-MsgGUID: ekk6hbGyQc22ulGS3pANEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78530899"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78530899"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 15:33:22 -0700
X-CSE-ConnectionGUID: X4PTUqY+R2239Xax3udwxA==
X-CSE-MsgGUID: X1OEPVh1SV+BkPlAo0QpsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="233230728"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.108.229]) ([10.125.108.229])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 15:33:22 -0700
Message-ID: <7e023076-6603-4a02-8e90-47bdad562b5e@intel.com>
Date: Tue, 28 Apr 2026 15:33:20 -0700
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
 <4a20f390-a49d-4a9f-911f-21c36449b990@intel.com>
 <CAJNyHpJjXCRitQykyNTseGGstP2XbRXroZ+YzkQxMLECj32BUw@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJNyHpJjXCRitQykyNTseGGstP2XbRXroZ+YzkQxMLECj32BUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/26 1:28 PM, Sungwoo Kim wrote:
> Dear Dave, thank you for sharing the patch that doesn't use the workqueue.
> 
> Claude suggests not using wq, since it's simpler. I agree that it's
> simple, but it's overly tailored to fix a specific bug.
> Actually, v1[1] proposed a similar patch. So let me bring a patch and
> discussion from v1:
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 08fa3deef70ab..7ade9aa2aeecc 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2745,12 +2745,19 @@ static ssize_t delete_region_store(struct device *dev,
>   struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
>   struct cxl_port *port = to_cxl_port(dev->parent);
>   struct cxl_region *cxlr;
> + int err;
> 
>   cxlr = cxl_find_region_by_name(cxlrd, buf);
>   if (IS_ERR(cxlr))
>   return PTR_ERR(cxlr);
> 
> - devm_release_action(port->uport_dev, unregister_region, cxlr);
> + err = devm_remove_action_nowarn(port->uport_dev, unregister_region,
> +       cxlr);
> + if (err) {
> + put_device(&cxlr->dev);
> + return err;
> + }
> + unregister_region(cxlr);
>   put_device(&cxlr->dev);
> 
>   return len;
> 
> However, v1 has not been merged. Dan[2] commented that "No, that is
> not an acceptable or comprehensive fix. A subsystem should never try
> to double unregister a device." Also in the following thread[3], "The
> patch was technically correct but it relies on a design that requires
> depending on a double free semantic."
> 
> I respect this design decision. Then, I need to execute
> devm_release_[action|all]() only once, which requires a device lock,
> guard(device)(port->uport_dev). Under a lock, I can check a flag to
> execute devm_release_[action|all]() only once.
> To use the lock, a clean work without a prior lock is required. That's
> a reason this patch ended up in wq.
> 
> I hope I've explained the rationale for using wq. What do you think?

Right I went back and also read what Dan proposed. I just wonder if we are over complicating things now and introducing more issues on top by doing that. Obviously we have to address the issues sachiko brought up in v3. Below is what claude suggested to fix the Sashiko issues in v3 patches. Some of the comments may be excessive but help reading through the changes.

Issue 1: Lockless read of p->interleave_ways
=============================================
Problem: unregister_region() reads p->interleave_ways without holding
the region rwsem while __construct_region() may still be initializing it
under write lock. This can result in reading 0 and skipping target
detachment, potentially causing use-after-free.

Solution: Acquire rwsem read lock before reading p->interleave_ways to
serialize with __construct_region(). Add explicit handling for
interleave_ways == 0 (uninitialized region) and use smp_rmb() to ensure
proper memory ordering.

Issue 2: Driver unbind/rebind race with workqueue
==================================================
Problem: The async workqueue could execute after driver unbind clears
the devres list, then operate on a new/empty list after rebind.

Solution: The workqueue already checks if driver is bound before calling
devm_remove_action(). Added cancel_work_sync() in cxl_region_release()
to ensure no dangling work when region is freed. Enhanced comments to
clarify the synchronization.

Issue 3: Use-after-free in construct_region() error path
=========================================================
Problem: In the original problematic code, calling unregister_region()
directly then get_device() created a window where concurrent
delete_region_store() could free the region.

Solution: Never call unregister_region() directly. The workqueue calls
devm_remove_action() which invokes unregister_region() in a safe context.
Reference transfer is now clean - caller's reference is transferred to
the workqueue, which drops it after work completes.

Key design:
- unregister_region() is ONLY called as a devm callback (driver unbind
  or workqueue via devm_remove_action())
- CXL_REGION_F_UNREGISTER flag is ONLY set by unregister_region() itself,
  preventing concurrent execution
- CXL_REGION_F_DEVM_REMOVE flag is set by workqueue to prevent duplicate
  devm_remove_action() calls
- Reference counting is clear: lookup refs are transferred to workqueue

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 08b93b14a2c7..4c5771bc4717 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2500,6 +2500,14 @@ static void cxl_region_release(struct device *dev)
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int id = atomic_read(&cxlrd->region_id);
 
+	/*
+	 * Ensure pending removal work completes before freeing.
+	 * This is safe even if called from within the work function
+	 * because cancel_work_sync() returns immediately if the work
+	 * is currently executing.
+	 */
+	cancel_work_sync(&cxlr->remove_work);
+
 	/*
 	 * Try to reuse the recently idled id rather than the cached
 	 * next id to prevent the region id space from increasing
@@ -2544,22 +2552,46 @@ static void unregister_region(void *_cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int i;
 
+	/*
+	 * This is ONLY called as a devm callback:
+	 * 1. During driver unbind (devres_release_all)
+	 * 2. Via devm_remove_action() from workqueue
+	 *
+	 * The UNREGISTER flag prevents concurrent execution if both
+	 * paths race (e.g., user delete concurrent with driver unbind).
+	 */
 	if (test_and_set_bit(CXL_REGION_F_UNREGISTER, &cxlr->flags))
 		return;
 
 	device_del(&cxlr->dev);
 
 	/*
-	 * Now that region sysfs is shutdown, the parameter block is now
-	 * read-only, so no need to hold the region rwsem to access the
-	 * region parameters.
+	 * Sysfs is shutdown, blocking new writers. However, __construct_region()
+	 * may still be initializing params under region rwsem write lock.
+	 * Acquire read lock to serialize and get consistent view of interleave_ways.
+	 *
+	 * If interleave_ways is 0, region was never fully initialized.
 	 */
+	guard(rwsem_read)(&cxl_rwsem.region);
+
+	/*
+	 * Ensure UNREGISTER flag check happens-before interleave_ways read.
+	 */
+	smp_rmb();
+
+	if (p->interleave_ways == 0) {
+		/* Not initialized - skip target detachment */
+		goto out;
+	}
+
 	for (i = 0; i < p->interleave_ways; i++)
 		detach_target(cxlr, i);
 
 	cxlr->hpa_range = DEFINE_RANGE(0, -1);
 
+out:
 	cxl_region_iomem_release(cxlr);
+	/* Drop the devm-owned reference */
 	put_device(&cxlr->dev);
 }
 
@@ -2842,22 +2874,59 @@ static bool remove_devm_actions(struct cxl_region *cxlr)
 	return schedule_cxl_region_remove_devm_actions(cxlr);
 }
 
+/**
+ * remove_devm_actions_work - Workqueue handler for region removal
+ * @work: work_struct embedded in cxl_region
+ *
+ * Runs in safe context where it can acquire locks and call
+ * devm_remove_action() which will invoke unregister_region() without deadlock.
+ *
+ * This ensures unregister_region() is called through the devm system.
+ */
 static void remove_devm_actions_work(struct work_struct *work)
 {
 	struct cxl_region *cxlr = container_of(work, typeof(*cxlr), remove_work);
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
 
+	/*
+	 * Prevent multiple attempts to remove devm actions.
+	 * If already set, another thread beat us to it.
+	 */
 	if (test_and_set_bit(CXL_REGION_F_DEVM_REMOVE, &cxlr->flags)) {
 		put_device(&cxlr->dev);
 		return;
 	}
 
+	/*
+	 * Lock port device and verify driver is still bound.
+	 * If driver was unbound, devres_release_all() already called
+	 * unregister_region() and the devres entry is gone.
+	 */
 	scoped_guard(device, port->uport_dev) {
-		if (port->uport_dev->driver)
+		if (port->uport_dev->driver) {
+			/*
+			 * Call devm_remove_action() which will:
+			 * 1. Find and remove the devres entry
+			 * 2. Call unregister_region(cxlr)
+			 *
+			 * The UNREGISTER flag in unregister_region() prevents
+			 * re-entry if this races with driver unbind.
+			 */
 			devm_remove_action(port->uport_dev, unregister_region, cxlr);
+		}
+		/*
+		 * If driver not bound, devres already released everything.
+		 * The UNREGISTER flag would have prevented duplicate execution.
+		 */
 	}
 
+	/*
+	 * Drop the extra reference taken when work was queued.
+	 * After this put_device(), if ref reaches 0, cxl_region_release()
+	 * will be called, which does cancel_work_sync() on this work item
+	 * (safe because we're about to return from the work function).
+	 */
 	put_device(&cxlr->dev);
 }
 
@@ -2868,17 +2937,40 @@ static ssize_t delete_region_store(struct device *dev,
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 	struct cxl_region *cxlr;
 
-	/* remove_devm_actions_work() will put cxlr->dev. */
+	/*
+	 * Look up region by name. Takes a reference that will be transferred
+	 * to the workqueue.
+	 */
 	cxlr = cxl_find_region_by_name(cxlrd, buf);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
-	unregister_region(cxlr);
+	/*
+	 * Queue work to remove devm action. The workqueue will call
+	 * devm_remove_action() -> unregister_region() in safe context.
+	 *
+	 * unregister_region() will set CXL_REGION_F_UNREGISTER to prevent
+	 * concurrent execution. We don't set it here because that would
+	 * cause unregister_region() to return early without cleanup.
+	 *
+	 * The work function expects to hold a reference, and will drop it
+	 * when done. We transfer our lookup reference to the workqueue.
+	 */
 	if (!remove_devm_actions(cxlr)) {
+		/*
+		 * Failed to queue work. This can happen if:
+		 * - Work already queued (another thread racing)
+		 * - Workqueue stopped
+		 * Drop our reference and return busy.
+		 */
 		put_device(&cxlr->dev);
 		return -EBUSY;
 	}
 
+	/*
+	 * Work queued successfully. The workqueue now owns our reference
+	 * and will drop it after calling devm_remove_action().
+	 */
 	return len;
 }
 DEVICE_ATTR_WO(delete_region);
@@ -3762,11 +3854,32 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	rc = __construct_region(cxlr, ctx);
 	if (rc) {
-		/* remove_devm_actions_work() will put the device */
-		get_device(&cxlr->dev);
-		unregister_region(cxlr);
-		if (!remove_devm_actions(cxlr))
+		/*
+		 * Construction failed. We need to unregister the region.
+		 * We hold a reference from __create_region() above.
+		 *
+		 * Queue work to remove devm action. The work will call
+		 * devm_remove_action() -> unregister_region() which will
+		 * set CXL_REGION_F_UNREGISTER to prevent concurrent execution.
+		 *
+		 * The work function expects a reference. We transfer our
+		 * reference from __create_region() to the workqueue.
+		 */
+		if (!remove_devm_actions(cxlr)) {
+			/*
+			 * Failed to queue work. This can happen if:
+			 * - Another thread already queued removal
+			 * - Workqueue is stopped
+			 *
+			 * In either case, drop our reference and let the other
+			 * path handle cleanup.
+			 */
 			put_device(&cxlr->dev);
+		}
+		/*
+		 * If work queued successfully, it now owns our reference
+		 * and will drop it after calling devm_remove_action().
+		 */
 
 		return ERR_PTR(rc);
 	}
