Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D842AB4
	for <linux-cxl@vger.kernel.org>; Tue, 26 Nov 2024 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617656; cv=none; b=IgevMbXjDlEjo5EQtlxdDPQWzFJVQBkK2d+tAgyDNwrHt+lrSPWsUSNQnKq8PmWPp/Pi2JS8B+JfEW+Ef7CYfYnhxPeboKT1rzbvyXrOFxt0ihYAj2h7Urn5nuVniSOSvDJY3a1YYLY52xEfF3gq0tbymJ744WbKeA4TaCO7m5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617656; c=relaxed/simple;
	bh=fqvmG11KBGW7acpt01H3h8P4/o+yzsvs9MQjXd4LFKc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyTcuCg4RMUPuebEswvcDuxQbemVW6IxgDwzZh4odNZMz+qDocL+ckNQQRfRvaa0vJJCC7d3Y4IblO+lrKyP7Xi+fruzlUH/MJ23KM9LTvs1fJZDhu7jg8L5rBUUWFQOrpTmVP1EvNgtm3kj9ALb5izxzipsSBy8CWEG//JrrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XyJxY1PCtz6LD8H;
	Tue, 26 Nov 2024 18:40:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AFAC91400CD;
	Tue, 26 Nov 2024 18:40:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Nov
 2024 11:40:48 +0100
Date: Tue, 26 Nov 2024 10:40:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <AbdulLateef.Attar@amd.com>, <gaoliming@byosoft.com.cn>,
	<zhiguang.liu@intel.com>, <michael.d.kinney@intel.com>,
	<marcin.juszkiewicz@linaro.org>, <chenbaozi@phytium.com.cn>,
	<devel@edk2.groups.io>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC EDK2 PATCH v4 1/1] MdePkg/IndustryStandard: add
 definitions for CXL CEDT
Message-ID: <20241126104046.0000427b@huawei.com>
In-Reply-To: <20241126030159.72111-2-wangyuquan1236@phytium.com.cn>
References: <20241126030159.72111-1-wangyuquan1236@phytium.com.cn>
	<20241126030159.72111-2-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 26 Nov 2024 11:01:59 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> This adds #defines and struct typedefs for the various structure
> types in the CXL Early Discovery Table (CEDT).
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Hi.

One errata applies. See below.

Otherwise,  I've checked these against the r3.2 specification and
they look correct.  Some suggestions on places where comments might
make that easier to establish when it comes to maximum sizing.
Otherwise, with the errata fixed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/MdePkg/Include/IndustryStandard/Cxl30.h b/MdePkg/Include/IndustryStandard/Cxl30.h
> index 7a9a6d69405d..63e56aea8254 100644
> --- a/MdePkg/Include/IndustryStandard/Cxl30.h
> +++ b/MdePkg/Include/IndustryStandard/Cxl30.h
> @@ -45,6 +45,13 @@
>  #define CXL_HDM_6_WAY_INTERLEAVING   0x9
>  #define CXL_HDM_12_WAY_INTERLEAVING  0xA
>  
> +///
> +/// "CEDT" CXL Early Discovery Table
> +///
> +#define CEDT_TYPE_CFMWS    0x1
> +#define CEDT_TYPE_CXIMS    0x2
> +#define CEDT_TYPE_RDPAS    0x3
> +
>  //
>  // Ensure proper structure formats
>  //
> @@ -311,6 +318,45 @@ typedef struct {
>    CXL_3_0_CXL_TIMEOUT_AND_ISOLATION_STATUS        TimeoutAndIsolationStatus;
>  } CXL_3_0_CXL_TIMEOUT_AND_ISOLATION_CAPABILITY_STRUCTURE;
>  
> +///
> +/// Definition for CXL Fixed Memory Window Structure (CFMWS)
> +///
> +typedef struct {
> +  CEDT_STRUCTURE                       Header;
> +  UINT32                               Reserved;
> +  UINT64                               BaseHpa;
> +  UINT64                               WindowSize;
> +  UINT8                                InterleaveMembers;
Spec naming now at least is Encode Number of Interleave Ways.
This name looses quite a bit of that.  I'd use a longer name,
perhaps EncodedInterleaveWays


> +  UINT8                                InterleaveArithmetic;
> +  UINT16                               Reserved1;
> +  UINT32                               Granularity;
> +  UINT16                               Restrictions;
> +  UINT16                               QtgId;
> +  UINT32                               TargetList[16];

Perhaps a comment on why 16 given it depends on decoded version
of EncodedInterleaveWays.  16 is the current maximum.

> +} CXL_FIXED_MEMORY_WINDOW_STRUCTURE;
> +
> +///
> +/// Definition for CXL XOR Interleave Math Structure (CXIMS)
> +///
> +typedef struct {
> +  CEDT_STRUCTURE                       Header;
> +  UINT16                               Reserved;
> +  UINT8                                HBIG;
> +  UINT8                                NIB;
> +  UINT64                               XORMAPLIST[4];

Why 4?  Number of entries depends on NIB. Add a comment if this
is the effective maximum to refer to specific part of spec that says that.


> +} CXL_XOR_INTERLEAVE_MATH_STRUCTURE;
> +
> +///
> +/// Definition for RCEC Downstream Port Association Structure (RDPAS)
> +///
> +typedef struct {
> +  CEDT_STRUCTURE                       Header;
> +  UINT16                               SegmentNumber;
> +  UINT16                               Bdf;
> +  UINT8                                ProtocolType;
> +  UINT64                               BaseAddress;

Always check the latest spec, which as of last week is 3.2 or
any errata released in the meantime.

There is an errata on this.  Key is that in the 3.1 and before
the fields don't fit.  Offset of RCEC BDF is 06h, length 2 bytes, yet
protocol type is in 07h so overlaps.

Fix was to move protocol type later.

> +} RCEC_DOWNSTREAM_PORT_ASSOCIATION_STRUCTURE;
> +
>  #pragma pack()
>  
>  #endif

