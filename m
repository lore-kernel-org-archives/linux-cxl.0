Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D01E35B645
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 06:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158970; cv=none; b=erC2CEjpTQVWQ3vgdoorsk1+EkxxYctj+6Nqma4f+XUFqf6tHOyaBmpn6U/UXIWYidm0IuPy0fTdQM0JdxGD63DtP3z4RpLRl2aIuE73e6IO6Me4fqcbIxjrLLzZi/Dbk3mKFemIfIv4TGpISoQJDuH72Vn7D9BE/YL71XbX3bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158970; c=relaxed/simple;
	bh=aOEGPw/vtOCxM66iJPQ6H7kLds48Kb65VpUxYO7XjUQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtuB+AwUZPeZurcVKS7ZDp1krcUx6WyIkKubNpjCX7oXDh3Ss1fl+8sZLODy3RGdi6ZjQHukwQkjr3VfP8gmjyu9VOFEJ1lOZhBA8PNF+f6KKLYnrsqrHd2xfXUUYpTAxu1Z8OocSN71Wi9MrFS3u2Xxg9ZC4yqcYe2JwDz/OQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMm7alMJ; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMm7alMJ"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30807ba471bso509344eec.1
        for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 23:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781158968; x=1781763768; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q+r5CsmNZ/qmFA19D/kuAvtdTU1zm5RqRVe0bN9E8Fk=;
        b=nMm7alMJc6bs0g29ZG2cqiY28C0ekeyFcLs3AUjPI5fOQltvd8VCRV9S1zmNI9Ja2M
         X7/X4UD2/LDyxes19WfF6swX4s/8hm29/dn8we97km5COPMbFtueFpFtS+wH41Z9XDWw
         HjX0Tdz5lRmVc+i9NYIeRe7aHA7/zS3QZljCSU/7j1YWIDkv4Jl3nIRv5hBUPrEMxqvL
         zegfHh0O7x7i7FlRe4sONKovjzq5jfVjKTht6T3zR4ulULBoGumvxrp2eHnZ4u72kVm9
         VzgwmR2gt8gAhJWythq0fe6yPK6IR3tEJOhvHXmEA5rc4ylBtlCpb8bPOzDHJktsg3t1
         nHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781158968; x=1781763768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+r5CsmNZ/qmFA19D/kuAvtdTU1zm5RqRVe0bN9E8Fk=;
        b=XZwaB3VDCahBjoc3rAvLMgKNbReNrTuO0uigDa7WO0U68sGenB7xkahU1N8nzznQtu
         m9Qx3fPxhf8rXKOEk4D0l48k6vUKN00tavf/t5NZuJ2CdA0syKRk0qP9L/JSqu+UCVvp
         pD2uXD2sqsuQvgBWoLdYxwidvYXYTtaIQ0N4BQeaI2Tg+mVUktW3D8aTN+RtczlKA2go
         KGAi6QNlzZfy2w85plfKY0Gqu1Ssl9hwoAjp6tZGl9tOzfRuZwMxIl9Mn3HJcWsr7Or/
         jAaRi+r1DgRZWsQ7GvM3zYPltYecXmsoRrwCEqEgicRWilStv8L3CkBtig7uh1956fWn
         1bRA==
X-Forwarded-Encrypted: i=1; AFNElJ/T2ZtEMkOdUZg6KAnSf7COtmfLAlNpSYmiaMAF0BzWHZ8Aa+yBo6v+4UoeaHFraH1FGcwrkegceF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO/8D9/dYyHdQLPtQ8KmULVuM32h35nybrHeGsuToWDYcTpGDR
	rV9wHzatRZ0t79b3WiLRcBwC1VatffG+xvzwJ0XPSAKyiWW1u4va8tqL4ah3DA==
X-Gm-Gg: Acq92OGid7jDeiBnREeBRPq3dHwuMmd7a7Q5atw0l+LRGuneVlJFiJHKExErtLYxxP8
	k04KG1KMMAUO2YfVVug4Rav9Qtq+56b/ePJDOjlJEwWRyAUGFwYTKrYsRyrlok9s+gS4fKKXRmT
	SPTrv0/Yc9YRAT2nVIcnigdTrJW4GcxeUce7UZpkeXfhx7Qh1SoGl6BNqTNSv77SeEJf+Avn8st
	ekc0nf77NjV0FKaR99xT8OWXKOglxN3bFe15I6KPwA+WmXSxJwCCdGFQ55Ph4BtU6PcmQjMya4A
	oISE+g4aFPjZj77RSYii7oEhQs18gvg3CzSE9BHTbwrmejwUMzTec7xdPP1sNs6mXUnzBi+Oapf
	qDVRH/uPB5UuJNou7zqiUj8eazG3ATDCVS0BO25anAG16F9NYMxOrSwUgiU5UXEka0v7lWudHfj
	9ZH+LEDVxL0xoKmZRhsBH+ZAmTn3j6T+np8Q0snkVoo5LX22LE31D8lZjQDbgHk7NbrTu0oSkjF
	e2RkXI9pRE8HJl4lQ==
X-Received: by 2002:a05:7300:7305:b0:304:c520:4e0c with SMTP id 5a478bee46e88-3080479b610mr1200660eec.6.1781158967959;
        Wed, 10 Jun 2026 23:22:47 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30806c2f3absm917761eec.5.2026.06.10.23.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:22:47 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 10 Jun 2026 23:22:45 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v10 15/31] cxl/mem: Drop misaligned DCD extent groups
Message-ID: <aipUNZIxgAenJjLM@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <60e23199f7ef7dd3008bb3275c40d242334275c9.1779528761.git.anisa.su@samsung.com>
 <c09e9ae9-d5b9-48b6-9225-98f53022545d@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c09e9ae9-d5b9-48b6-9225-98f53022545d@intel.com>

On Thu, May 28, 2026 at 02:03:12PM -0700, Dave Jiang wrote:
> 
> 
> On 5/23/26 2:43 AM, Anisa Su wrote:
> > Add an alignment gate to cxl_add_pending(): every extent in a tag group
> > must have its start_dpa and length aligned to CXL_DCD_EXTENT_ALIGN (SZ_2M,
> > the minimum device-dax mapping granularity on every architecture that
> > enables CXL DCD).  A misaligned extent makes the resulting dax device
> > unusable, so drop the whole group rather than accept a partial allocation
> > that would surface a broken dax_resource.
> > 
> > Based on patches by John Groves.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: John Groves <John@Groves.net>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > 
> > ---
> > Changes:
> > [anisa: split out as a separate validation step]
> > ---
> >  drivers/cxl/core/mbox.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index e5edc3975e8f..421bd716a273 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/unaligned.h>
> >  #include <linux/list.h>
> >  #include <linux/list_sort.h>
> > +#include <linux/sizes.h>
> >  #include <cxlpci.h>
> >  #include <cxlmem.h>
> >  #include <cxl.h>
> > @@ -1280,6 +1281,24 @@ static int add_to_pending_list(struct list_head *pending_list,
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Device-dax requires extent boundaries aligned to its mapping granularity.
> > + * Use SZ_2M as a conservative default; a tighter check that queries the
> > + * cxl_dax_region / cxl_endpoint_decoder for its actual alignment would be
> > + * strictly more correct, but SZ_2M is the minimum device-dax supports on
> > + * every architecture that enables CXL DCD today.
> > + */
> > +#define CXL_DCD_EXTENT_ALIGN	SZ_2M
> 
> Wonder if this would cause issues in DAX on ARM64 with 64k page size since its PMD size is 512M. 
> 
Changed to use PMD_SIZE

> DJ
> > +
> > +static bool cxl_extent_dcd_aligned(const struct cxl_extent *extent)
> > +{
> > +	u64 start = le64_to_cpu(extent->start_dpa);
> > +	u64 len = le64_to_cpu(extent->length);
> > +
> > +	return IS_ALIGNED(start, CXL_DCD_EXTENT_ALIGN) &&
> > +	       IS_ALIGNED(len, CXL_DCD_EXTENT_ALIGN);
> > +}
> > +
> >  /*
> >   * Compare two extents by shared_extn_seq (ascending).  list_sort is
> >   * stable so when shared_extn_seq is 0 for every entry (non-sharable
> > @@ -1352,6 +1371,26 @@ static int cxl_add_pending(struct cxl_memdev_state *mds)
> >  		extract_tag_group(pending, &tag, &group);
> >  		list_sort(NULL, &group, extent_seq_compare);
> >  
> > +		/* Alignment gate — abort the group if any member fails */
> > +		bool aligned = true;
> 
> declaring var in middle of code
> 
Moved up
> > +		list_for_each_entry(pos, &group, list) {
> > +			if (!cxl_extent_dcd_aligned(pos->extent)) {
> > +				dev_warn(dev,
> > +					 "Tag %pUb: dropping group, extent DPA:%#llx LEN:%#llx not %u-aligned\n",
> > +					 &tag,
> > +					 le64_to_cpu(pos->extent->start_dpa),
> > +					 le64_to_cpu(pos->extent->length),
> > +					 CXL_DCD_EXTENT_ALIGN);
> > +				aligned = false;
> > +				break;
> > +			}
> > +		}
> > +		if (!aligned) {
> > +			list_for_each_entry_safe(pos, tmp, &group, list)
> > +				delete_extent_node(pos);
> > +			continue;
> > +		}
> > +
> >  		u16 logical_seq = 1;
> 
> Looks like this one came from a previous patch.
> 
Moved up in prev patch

Thanks,
Anisa
> 
> >  		list_for_each_entry_safe(pos, tmp, &group, list) {
> >  			u16 raw = le16_to_cpu(pos->extent->shared_extn_seq);
> 
