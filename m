Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C453FC5BD
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180509; cv=none; b=iL1BkkDYDx+8Fxyy5uhAFYdRNWs2iD6LA/Cv8Aq3RQLL5gLcNVbM5KNfOPqx4JBUpc1WqFeM8vHzFyLlHtW1F7PBdiWqHRvxIpk+xK+/rskKFp2XkEidj2tPo3+it5sz8jgLuBsfuTWAT4pM6cbIQsEgQkuvN5VNtF0za9JVtmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180509; c=relaxed/simple;
	bh=ALpUsW4RB6FAZfTMM6XjP4ExbIqI7ptu6L4mc9zqHxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMDKvLSDeHqW+5MYn0sEKRtLKdN9oMhmwc3pi5IIav72elAFxgmYBAC1zeaECCEWiPr90SP0qsIGF8P1WAK96wH2Ox3pXsrHxHEpq/+hac+HXP6l1EVefHqq1nHM+ahXUK1KuKHiTNgRsHx3P/vmQgbowbou3NiN1mGJNcWDJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZIoVCaO0; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZIoVCaO0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788180498; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7/bbLv5jlHaqn/N9XI6NDrdF1KCzin1qElFis/mB978=;
	b=ZIoVCaO0mVSm540gmlHbcerDEHZlnrqSPkbE1zpp9YBCoUKdH9Y3hpsFtfatP92dRAAzREa+9MDBuPC73NsiU8ulHDksbzyVBT+u7hm6/mckutWN8Yrs2blY+SqV10AdR1iSk9UycUQVEEnIzq3JPb83E+bp/2NzzDq7IS0yGqA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X9yvJ0R_1788180497;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9yvJ0R_1788180497 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 20:48:18 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH v2 1/2] driver core: Add conditional guard support for device_trylock()
Date: Mon, 31 Aug 2026 20:48:08 +0800
Message-ID: <20260831124809.889829-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260831124809.889829-1-kanie@linux.alibaba.com>
References: <20260831124809.889829-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a conditional guard version of device_trylock() for scenarios
that must not block on the device lock. device_trylock() returns 1 on
success like mutex_trylock(), so the default binary condition applies and
ACQUIRE_ERR() reports -EBUSY on contention.

Suggested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 include/linux/device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 7b2baffdd2f5..34b2cd40fea4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1119,6 +1119,7 @@ static inline void device_unlock(struct device *dev)
 
 DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
 DEFINE_GUARD_COND(device, _intr, device_lock_interruptible(_T), _RET == 0)
+DEFINE_GUARD_COND(device, _try, device_trylock(_T))
 
 static inline void device_lock_assert(struct device *dev)
 {

base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.7

