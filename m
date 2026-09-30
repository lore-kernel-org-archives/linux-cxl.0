Received: from outbound.baidu.com (mx21.baidu.com [220.181.3.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D65469822;
	Wed, 30 Sep 2026 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759508; cv=none; b=PWyaBTtJZ9jabPTNyBxUaSYUhu4CFE+veTZje+cnmDgGJ11ZtMZ47I0nPGsJ9SM8c1NNCrYUQfVwdpAU4clmVYMB1s8fwYjtYtWBzrxjbOCOsjn3CAk5hsqVGfg9a3ySJIcAx/Xe/Sg3oc3yiEgUf3T9oM1FLGB6wbbp+VtWDWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759508; c=relaxed/simple;
	bh=mrvX5IGkSuoqsd7ntMM6S9cEXpbdR7LhQaMXhLBY55o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lybUjEnPRXXqrNoS9SKyhmcisQaKNotQ5iE3hfY7i9XLU/4W/Y9dlRrB2M7rMtGfZTalGTSE2/vn7QT5NposrEbbDbkTDgSFWbzyGM4GOLXbRknDGCjY0kU5FLTfcmFsLGEAQiJNxB1izdIqXqZpK5p30DOkVyFpS1BN44pyd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=BeCkWV2a; arc=none smtp.client-ip=220.181.3.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="BeCkWV2a"
X-MD-Sfrom: zhangyili01@baidu.com
X-MD-SrcIP: 172.31.51.15
From: Yili Zhang <zhangyili01@baidu.com>
To: <alison.schofield@intel.com>
CC: <dave.jiang@intel.com>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shiju.jose@huawei.com>, <vishal.l.verma@intel.com>, <zhangyili01@baidu.com>
Subject: Re: [PATCH] cxl/edac: Bounds-check ECS threshold index from device
Date: Wed, 30 Sep 2026 17:09:23 +0800
Message-ID: <20260930090923.29654-1-zhangyili01@baidu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arv6_znTtwN4JExY@aschofie-mobl2.lan>
References: <arv6_znTtwN4JExY@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc2.internal.baidu.com (172.31.50.46) To
 BJKJY-Exc19.internal.baidu.com (172.31.51.15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1790759371;
	bh=HOJ1Ppod1GGVWlnVAn8nYirx+1WBbe32blZoFsytVkg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=BeCkWV2a+F1aDpouLtO/pZ50pvphQOSV7CSrMBURgRRvI1qJdHV80FOwdwUwwItsL
	 RMhucNkWr+bx1w1Mt3bcVABAkXxjJE0uQWx1mz1RYmMikksbGi6bMFHaQc2JkqfnwC
	 KHx82c0WVKRIUO1aaKBRBTqSLrYoi4krjllW3yz50b2ykjHZgUVI2VYpyehjoa6Elc
	 vqz31sa0txKgMKsAMg+RR6CuyoE4HnqhiNKydmWz2DxLv37jERDX0wlkpMpuT8xVVm
	 FwyJrPb8QmfJYK5VaUmqf82URQwSEKcvKYUZjoF2PYDfM4AmnZaN+lMrhqK3Xa38rL
	 i0drZh27ws5UQ==

On 2026-09-29 10:53, Alison Schofield wrote:
> 
> Hi Yili,
> 
> I see the appeal of keeping this as the smallest possible fix, but is the
> existing behavior for 0-2 something we intentionally want to preserve, or
> just how the current implementation works?
> 
> Documentation/ABI/testing/sysfs-edac-ecs lists 256, 1024, and 4096 as the
> threshold values. If 0 is meant to represent a reserved encoding, should
> that be part of the documented ABI?

Hi Alison,

You're right on both counts.

The 0-2 behavior is not something we want to preserve; it is just
an artifact of the sparse array's implicit zero-fill. The ABI documentation
only lists 256, 1024 and 4096 as supported values, so rather than documenting
0 as well, make the read fail for all reserved encodings and only ever report
the documented values.

> Does CXL_ECS_GET_ATTR() itself prevent that? It already has an int return
> path and can return errors from cxl_mem_ecs_get_attrbs().
> 
> Is the real limitation just the interface used by the cxl_get_ecs_*()
> helpers? Would something like this work:
> 
> 
> static int cxl_get_ecs_threshold(u8 log_cap, u16 config, u16 *threshold)
> {
> 	u8 index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK, config);
> 
> 	if (index >= ARRAY_SIZE(ecs_supp_threshold) ||
> 	    !ecs_supp_threshold[index])
> 		return -EINVAL;
> 
> 	*threshold = ecs_supp_threshold[index];
> 	return 0;
> }

And you're correct that CXL_ECS_GET_ATTR() already propagates errors;
the only real limitation was the helper signature, as you sketched.
v2 restructures the cxl_get_ecs_*() helpers to return int with an
output parameter and updates the macro accordingly.

v2 follows shortly.

Thanks,
Yili
