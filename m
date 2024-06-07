Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A9A18732D;
	Fri,  7 Jun 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773209; cv=none; b=Bixbs/h4iq+fkbPiD7Xmh1vOv19W+clbYRPHofMyT30nzP0C9wM/kH+yKDmrKhsN124mcEq2sXKTGaQppBxyt0qoCOQWDTi4eqnTR4qES6JmG+p4XI9ybsw1C61tVskgalIjUQRPV670yHKA5u8JtAt/KwgC67iWBfOYoq85+2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773209; c=relaxed/simple;
	bh=Qz/aA87n1W3Jvbb2hp8KC483bwpvzJetmsqSha04DoE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcxVzshJQAAEnN/dXszFg4msjCIVux3vy5lDvCxv++qIRVMP+VAD9yRHxbuLeBKSM4j5/yreAaqPgniLG9jAWKPcUvHPk9cu+oBt+PHaobOs4pJlVrucQKaffPUtL+w98ZEVzcwH/bqWABpyfb/h7bcm3tjXQhkT7tZjiMsBkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vwl2c2yJLz6GBnb;
	Fri,  7 Jun 2024 23:08:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 20137140C98;
	Fri,  7 Jun 2024 23:13:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 16:13:22 +0100
Date: Fri, 7 Jun 2024 16:13:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: avidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] cxl/events: Use a common struct for DRAM and General
 Media events
Message-ID: <20240607161321.0000420b@Huawei.com>
In-Reply-To: <20240607144423.48681-1-fabio.m.de.francesco@linux.intel.com>
References: <20240607144423.48681-1-fabio.m.de.francesco@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri,  7 Jun 2024 16:43:58 +0200
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> cxl_event_common was an unfortunate naming choice and caused confusion with
> the existing Common Event Record. Furthermore, its fields didn't map all
> the common information between DRAM and General Media Events.
> 
> Remove cxl_event_common and introduce cxl_event_media_hdr to record common
> information between DRAM and General Media events.
> 
> cxl_event_media_hdr, which is embedded in both cxl_event_gen_media and
> cxl_event_dram, leverages the commonalities between the two events to
> simplify their respective handling.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
With the fix for my mistake in v6 review.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  
> +struct cxl_event_media_hdr {
> +	struct cxl_event_record_hdr hdr;
> +	__le64 phys_addr;
> +	u8 descriptor;
> +	u8 type;
> +	u8 transaction_type;
> +	/*
> +	 * The meaning of Validity Flags after bit 2 is
oops. I got this wrong. Sorry!

"from bit 2" 
after would not include bit 2 which is "nibble" for dram and 
"device" for media.

Maybe if Dave is happy with this one otherwise he can tidy that
up whilst applying?
 

> +	 * different across DRAM and General Media records
> +	 */
> +	u8 validity_flags[2];
> +	u8 channel;
> +	u8 rank;
> +} __packed;
> +
