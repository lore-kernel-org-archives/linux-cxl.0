Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD24255E42
	for <linux-cxl@vger.kernel.org>; Wed, 12 Feb 2025 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380511; cv=none; b=M0xcL8qarVRv5HvJknXQeSaYYktPt2iNQ4j5UCJv4Ds9UwVYxVC9zpD/4FN5qjtxBDuAgKm5K/LQvbzpdQYwt7tLov27taFg6QfMp+R3QqidbhpQwW5JjQUPy/DL2atBdIUhQJo8mCASaTDmKlsCD+0aVDL8xN1t191yQKuE82g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380511; c=relaxed/simple;
	bh=uWUi8euyjiuDiN0xhD+YV0zTLxgAYZ8lhDXVG9cYDq0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NL1pLrU6WJ+LdM3SKJCCuiDkzt59xYdBnGpwCQaExRGiztba7KuTCYA9Iw72kphAS2+PcqJzp/ljV/aKi/F35/MZURB8nZRvgwXftLsz5w9A0aCYu1Cpi7NDYl0+0r9MPReVLQ9fiAnZEtMzOfArUEsxnSWYBt13f8O6Uyd9qn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtPxd2Dkmz6L55p;
	Thu, 13 Feb 2025 01:12:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 05D6B140441;
	Thu, 13 Feb 2025 01:15:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 18:15:05 +0100
Date: Wed, 12 Feb 2025 17:15:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<vishak.g@samsung.com>, <krish.reddy@samsung.com>,
	<a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH 1/3] hw/cxl/cxl-mailbox-utils.c: Added support for Get
 Log Capabilities (Opcode 0402h)
Message-ID: <20250212171504.000051b7@huawei.com>
In-Reply-To: <20250212113012.datt6a7sddkbli25@test-PowerEdge-R740xd>
References: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
	<CGME20250203060051epcas5p350b7b24d3b5fcff25bc30e1acccd8121@epcas5p3.samsung.com>
	<20250203055950.2126627-2-arpit1.kumar@samsung.com>
	<20250204102820.000047fb@huawei.com>
	<20250212113012.datt6a7sddkbli25@test-PowerEdge-R740xd>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

> >>
> >> +static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
> >> +    [CEL] = {.param_flags.pflags = CXL_LOG_CAP_CLEAR | CXL_LOG_CAP_POPULATE,
> >> +             .uuid = cel_uuid},
> >> +};
> >> +
> >> +static void cxl_init_get_log(CXLCCI *cci)
> >> +{
> >> +    for (int set = CEL; set < MAX_LOG_TYPE; set++) {
> >> +        cci->supported_log_cap[set] = cxl_get_log_cap[set];  
> >
> >As below. Can we just use a static const pointer in cci?  
> 
> static const pointer in cci gives compilation error as it used below
> to assign value:
>      cci->supported_log_cap[set] = cxl_get_log_cap[set];

True. That is what I am suggesting changing.

cci->supported_log_cap = cxl_get_log_cap;

This is currently iterating over a list and copying everything. Why
bother, just set a pointer to the source list.  If there
are choices for that, pick between them but keep all those lists const.



> 

> >> +typedef struct CXLLogCapabilities {
> >> +    CXLParamFlags param_flags;
> >> +    QemuUUID uuid;
> >> +} CXLLogCapabilities;
> >> +
> >>  typedef struct CXLCCI {
> >>      struct cxl_cmd cxl_cmd_set[256][256];
> >>      struct cel_log {
> >> @@ -202,6 +230,9 @@ typedef struct CXLCCI {
> >>      } cel_log[1 << 16];
> >>      size_t cel_size;
> >>
> >> +    /* get log capabilities */
> >> +    CXLLogCapabilities supported_log_cap[MAX_LOG_TYPE];  
> >Perhaps a const pointer is appropriate?  
> 
> const pointer here gives compilation error as it is used below 
> to assign value:
>      cci->supported_log_cap[set] = cxl_get_log_cap[set];
As above.  This set is the thing I'm suggesting changing.

One general review process thing is it is much more productive
to just crop anything you agree with and just have the discussion
focused on questions etc that are outstanding.

Jonathan
