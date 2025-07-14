Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B262260580;
	Mon, 14 Jul 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510510; cv=none; b=Wx5/SdeXaLWIVVZNpv+gvgQcaa6uaQZQ5GNRzxtxTjtTDHp43iZAUExPGwQCk/1E2dCqxOpAJLYNSyjdbYSDFMQX6LdUjYFb46vP9NS7VkP/RvdEyEDuAPq5tETvHSvOgm3/X05dfhEfKeK3l5kqrKAkK0TVMIeyiVBiYD48U7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510510; c=relaxed/simple;
	bh=+5kEwgQzjaASRloqt5fWQWCM7O0SdzAdNy7bCPc+Q5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P5Y8FQcOgGd/GiJr9UFFtzR65cOWzPuptGjPD5u9/B+qf7y1PKm2jxWFHr0mnglCmFBrxpQ2e5NGl9oroRt+z9ASbQFxxddNT680mBKOHU6mkkiz1hwaBsiNnZtUaJfOvl6AfozMNw1nL/jRcfHl8uOQYDne6Q63tYAYwRXA+ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgnlq2R0Gz6L5Gx;
	Tue, 15 Jul 2025 00:27:19 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F493140275;
	Tue, 15 Jul 2025 00:28:24 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 18:28:23 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 14 Jul 2025 18:28:23 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Peter Zijlstra <peterz@infradead.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>, Ingo Molnar
	<mingo@kernel.org>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, "Davidlohr Bueso"
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, Dave
 Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>
Subject: RE: [PATCH v3 8/8] cxl: Convert to ACQUIRE() for conditional rwsem
 locking
Thread-Topic: [PATCH v3 8/8] cxl: Convert to ACQUIRE() for conditional rwsem
 locking
Thread-Index: AQHb8r6Ir5Mnvswws02cjfabWtneq7QxxK1Q
Date: Mon, 14 Jul 2025 16:28:23 +0000
Message-ID: <a49ab85cbd70469c8d1ebb9a43db0517@huawei.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
 <20250711234932.671292-9-dan.j.williams@intel.com>
In-Reply-To: <20250711234932.671292-9-dan.j.williams@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Dan Williams <dan.j.williams@intel.com>
>Sent: 12 July 2025 00:50
>To: linux-cxl@vger.kernel.org
>Cc: linux-kernel@vger.kernel.org; David Lechner <dlechner@baylibre.com>;
>Peter Zijlstra <peterz@infradead.org>; Linus Torvalds <torvalds@linux-
>foundation.org>; Ingo Molnar <mingo@kernel.org>; Fabio M. De Francesco
><fabio.m.de.francesco@linux.intel.com>; Davidlohr Bueso <dave@stgolabs.net=
>;
>Jonathan Cameron <jonathan.cameron@huawei.com>; Dave Jiang
><dave.jiang@intel.com>; Alison Schofield <alison.schofield@intel.com>; Vis=
hal
>Verma <vishal.l.verma@intel.com>; Ira Weiny <ira.weiny@intel.com>; Shiju J=
ose
><shiju.jose@huawei.com>
>Subject: [PATCH v3 8/8] cxl: Convert to ACQUIRE() for conditional rwsem lo=
cking
>
>Use ACQUIRE() to cleanup conditional locking paths in the CXL driver The
>ACQUIRE() macro and its associated ACQUIRE_ERR() helpers, like
>scoped_cond_guard(), arrange for scoped-based conditional locking. Unlike
>scoped_cond_guard(), these macros arrange for an ERR_PTR() to be retrieved
>representing the state of the conditional lock.
>
>The goal of this conversion is to complete the removal of all explicit unl=
ock calls
>in the subsystem. I.e. the methods to acquire a lock are solely via guard(=
),
>scoped_guard() (for limited cases), or ACQUIRE(). All unlock is implicit /=
 scope-
>based. In order to make sure all lock sites are converted, the existing rw=
sem's
>are consolidated and renamed in 'struct cxl_rwsem'. While that makes the p=
atch
>noisier it gives a clean cut-off between old-world (explicit unlock allowe=
d), and
>new world (explicit unlock deleted).
>
>Cc: David Lechner <dlechner@baylibre.com>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Cc: Linus Torvalds <torvalds@linux-foundation.org>
>Cc: Ingo Molnar <mingo@kernel.org>
>Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>Cc: Dave Jiang <dave.jiang@intel.com>
>Cc: Alison Schofield <alison.schofield@intel.com>
>Cc: Vishal Verma <vishal.l.verma@intel.com>
>Cc: Ira Weiny <ira.weiny@intel.com>
>Cc: Shiju Jose <shiju.jose@huawei.com>
>Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Hi Dan,

For changes in CXL EDAC (drivers/cxl/core/edac.c),
Tested-by: Shiju Jose <shiju.jose@huawei.com>

>---
> drivers/cxl/core/cdat.c   |   6 +-
> drivers/cxl/core/core.h   |  17 ++-
> drivers/cxl/core/edac.c   |  44 +++---
> drivers/cxl/core/hdm.c    |  41 +++---
> drivers/cxl/core/mbox.c   |   6 +-
> drivers/cxl/core/memdev.c |  50 +++----
> drivers/cxl/core/port.c   |  18 +--
> drivers/cxl/core/region.c | 295 ++++++++++++++++----------------------
> drivers/cxl/cxl.h         |  13 +-
> include/linux/rwsem.h     |   1 +
> 10 files changed, 212 insertions(+), 279 deletions(-)
>
[...]
>diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c index
>2cbc664e5d62..f1ebdbe222c8 100644
>--- a/drivers/cxl/core/edac.c
>+++ b/drivers/cxl/core/edac.c
>@@ -115,10 +115,9 @@ static int cxl_scrub_get_attrbs(struct
>cxl_patrol_scrub_context *cxl_ps_ctx,
> 						flags, min_cycle);
> 	}
>
>-	struct rw_semaphore *region_lock __free(rwsem_read_release) =3D
>-		rwsem_read_intr_acquire(&cxl_region_rwsem);
>-	if (!region_lock)
>-		return -EINTR;
>+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
>+	if ((ret =3D ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
Checkpatch is giving error here and in other places with similar coding sty=
le, =20
"ERROR: do not use assignment in if condition"

>+		return ret;
>
[...]
> 		p =3D &cxlr->params;
>@@ -2215,18 +2173,18 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
> 	struct cxl_region *detach;
>
> 	/* when the decoder is being destroyed lock unconditionally */
>-	if (mode =3D=3D DETACH_INVALIDATE)
>-		down_write(&cxl_region_rwsem);
>-	else {
>-		int rc =3D down_write_killable(&cxl_region_rwsem);
>+	if (mode =3D=3D DETACH_INVALIDATE) {
>+		guard(rwsem_write)(&cxl_rwsem.region);
>+		detach =3D __cxl_decoder_detach(cxlr, cxled, pos, mode);
>+	} else {
>+		int rc;
>
>-		if (rc)
>+		ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
>+		if ((rc =3D ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> 			return rc;
>+		detach =3D __cxl_decoder_detach(cxlr, cxled, pos, mode);
> 	}
May be detach =3D __cxl_decoder_detach(cxlr, cxled, pos, mode);
add outside if ... else as before?
>
>-	detach =3D __cxl_decoder_detach(cxlr, cxled, pos, mode);
>-	up_write(&cxl_region_rwsem);
>-
> 	if (detach) {
> 		device_release_driver(&detach->dev);
> 		put_device(&detach->dev);
>@@ -2234,29 +2192,35 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
> 	return 0;
> }
[...]
> /*
>  * downgrade write lock to read lock
>--
>2.50.0
>

Thanks,
Shiju
