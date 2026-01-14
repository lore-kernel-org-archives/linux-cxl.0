Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066931355E;
	Wed, 14 Jan 2026 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415613; cv=none; b=tBvGMG86VNQXqJI8nMB5rRBKnus64fFYEda75W0+cbAu30NwIGR6uh23boz/CweyZlTLFbnnC4mQ9S8S10LqHKXte7xg2SzclUcaDmKurarwpRsGFQBnRgpunj6MdauQ3phFCBgXwDWa7v0rSWEUAMTfEGkJtTRzsTsAaCHYpXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415613; c=relaxed/simple;
	bh=fGGqR6y9h4qe0r8RxYqHP/QeB5sIB2RYjeqv7R9q7SE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D611s991FwuXsx1kDPSiwC9lw5/xuediHZ7LXMn+kWixlrFnpK74ALtx0jfwHIaqqw5tc7o90SCskc9bEvc0ekkIFn2uM4lF6poW33wccOrxk/dhXaJHHutaFW+2RpH+dU0b0JDnUX1Ygxwk30z8yG3z5qVWATM9Ns1zH0LZcDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drvr51J8ZzJ467F;
	Thu, 15 Jan 2026 02:33:09 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3865240086;
	Thu, 15 Jan 2026 02:33:24 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 18:33:23 +0000
Date: Wed, 14 Jan 2026 18:33:21 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v10 13/13] cxl: Disable HPA/SPA translation handlers for
 Normalized Addressing
Message-ID: <20260114183321.000074f2@huawei.com>
In-Reply-To: <c3ea841a-a220-438b-84c3-cabb73da94d4@intel.com>
References: <20260114164837.1076338-1-rrichter@amd.com>
	<20260114164837.1076338-14-rrichter@amd.com>
	<c3ea841a-a220-438b-84c3-cabb73da94d4@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 11:28:31 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 1/14/26 9:48 AM, Robert Richter wrote:
> > The root decoder provides the callbacks hpa_to_spa and spa_to_hpa to
> > perform Host Physical Address (HPA) and System Physical Address
> > translations, respectively. The callbacks are required to convert
> > addresses when HPA != SPA. XOR interleaving depends on this mechanism,
> > and the necessary handlers are implemented.
> > 
> > The translation handlers are used for poison injection
> > (trace_cxl_poison, cxl_poison_inject_fops) and error handling
> > (cxl_event_trace_record).
> > 
> > In AMD Zen5 systems with Normalized Addressing, endpoint addresses are
> > not SPAs, and translation handlers are required for these features to
> > function correctly.
> > 
> > Now, as ACPI PRM translation could be expensive in tracing or error
> > handling code paths, do not yet enable translations to avoid its
> > intensive use. Instead, disable those features which are used only for
> > debugging and enhanced logging.
> > 
> > Introduce the flag CXL_REGION_F_NORM_ADDR that indicates Normalized
> > Addressing for a region and use it to disable poison injection and DPA
> > to HPA conversion.
> > 
> > Note: Dropped unused CXL_DECODER_F_MASK macro.
> > 
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>  
> 
> As you mentioned commit log needs updating, otherwise
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Just goes to show one should always refresh email even when half way through
reviewing a patch series :)

Jonathan
