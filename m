Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8701DE3A9
	for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185174; cv=none; b=g9iJ2g+Jag+2+Fr67zQsaM+7Qvx/Rkutr8epDOwS+7ry3ZbPeaf7jqtrV+OLKcz5lJ6OHqF2AMELJ8dbTewNzQNwYmBkOdaH0WEtwrRCDr40lhrrdOGeRIW2MFr8T9VCtomUVwOp9BpKu+6/YFaiNYkuLYY/gtpZh0vUmovek9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185174; c=relaxed/simple;
	bh=OZAqWzwsd3cHoIp5FoT9NWPGyXT6zpZO0CBEhx0C/C0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUOudy47MsCtpq0jWv2p+S6MMBFRdmjv0JHyQBnio4btfYuFSGLuvhiGp01HRdhFEGZT39Pj9XX7UoQx4hMfalH7KU/siWqGlmU1lbKZRiRXCeIP6KhPU5K4YgCx4IhJTWOYkVPQQ2UNu2qWd8jjIEPMbzakVXNIw9Z1+HCDokk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTvX55VP3z6K9C9;
	Fri, 18 Oct 2024 01:12:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AE19140B67;
	Fri, 18 Oct 2024 01:12:46 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 19:12:45 +0200
Date: Thu, 17 Oct 2024 18:12:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Li Ming <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [bug report] cxl/port: Use scoped_guard()/guard() to drop
 device_lock() for cxl_port
Message-ID: <20241017181244.00003e1f@Huawei.com>
In-Reply-To: <67113c1775a7f_10a03294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain>
	<671044082f7de_3ee22945a@dwillia2-xfh.jf.intel.com.notmuch>
	<20241017160445.00005c50@Huawei.com>
	<67113c1775a7f_10a03294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 09:32:23 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> [..]
> > > In general for CXL I want to say that no function should be converted to
> > > use cleanup helpers unless all gotos are removed at once, and if the
> > > conversion needs to reach for scoped_guard() reconsider even attempting
> > > the conversion. I.e. scoped_guard() is a leading indicator for needing
> > > code refactoring.  
> > 
> > I don't think it's a bug and ultimately Dan C didn't say it was.
> > It's ugly but a simpler path to resolve it logically is to
> > stop using the variable port for two purposes.  
> [..]
> > 			/* retry find to pick up the new dport information */
> > 			port = find_cxl_port_at(parent_port, dport_dev, &dport);
> > 			if (!port)
> > 				return -ENXIO;
> > 		}
> > 	}
> > 
> > Whilst I don't like the code, I'm not sure a revert is the best way out.  
> 
> The revert is for the scoped_guard() conversion which was, innocently,
> trying to preserve the subtlety of the existing code.
> 
> It is true that the subsequent find_cxl_port_at() saves this being an
> actual bug by elevating the new port's refcount, but it is subtle beyond
> reason. This whole function needs a re-think, not more band-aids. I will
> fix up the reverts to drop "Fixes:" since you are right there is no
> actual bug, and those can wait for 6.13, but intent is to say "let's not
> use scoped_guard() in CXL without an exceedingly good reason".
> 
That's fair.  Let's also rename that variable so there is less subtle
code involved.

Jonathan

