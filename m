Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CF30BF60;
	Wed, 14 Jan 2026 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414683; cv=none; b=dqtXXMvbOdbeJI5sD9ePb5m++IKZue/kY4azFAJjWP68ncEWKqQQuztVc8oMOGD+XpVzhQOlAJYMY/mU+2CERDbjRzxWBgzQNJkdOMNCxxpTf2X4eZHfNPYi5tHn7jl/Iu8w69xVBuI/23YfdpYkqtpQ8fF3pxoI+23x0xyD7Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414683; c=relaxed/simple;
	bh=L20rnwyzQ7YCIodT/ZG5nOGwREc5Z9g4mcO7HTv6SBg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kh8eRBEqHjhayNJ4iF3W/HYR1vsUyuec1KSfTNak9/ySBmVWgjM8byoMruz9AJ8X4woWXsBv6QEh4NnSHDAu1irroK5HY9PU5yT0BDfkBA4g0vW7Mf0D8C48ruk2RR5OBSo5rKCOyBEHXgqSWTZv4DH5P1JveBn6sMbM5afBW68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drvVB2yNKzHnGcS;
	Thu, 15 Jan 2026 02:17:38 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C744E40569;
	Thu, 15 Jan 2026 02:17:58 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 18:17:58 +0000
Date: Wed, 14 Jan 2026 18:17:56 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Robert Richter <rrichter@amd.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 12/13] cxl/region: Factor out code into
 cxl_region_setup_poison()
Message-ID: <20260114181756.0000364f@huawei.com>
In-Reply-To: <aWcOZi7hP3qksmBh@aschofie-mobl2.lan>
References: <20260110114705.681676-1-rrichter@amd.com>
	<20260110114705.681676-13-rrichter@amd.com>
	<aWcOZi7hP3qksmBh@aschofie-mobl2.lan>
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

On Tue, 13 Jan 2026 19:32:54 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> On Sat, Jan 10, 2026 at 12:46:57PM +0100, Robert Richter wrote:
> > Poison injection setup code is embedded in cxl_region_probe(). For
> > improved encapsulation, readability, and maintainability, factor out
> > code into function cxl_region_setup_poison().
> > 
> > This patch is a prerequisit to disable poison injection for Normalized
> > Addressing.  
> 
> I prefer we be clearer about intent. Poison injection altogether is not
> being disabled, only by region offset. 
> 
> Replace this:
> > This patch is a prerequisit to disable poison injection for Normalized
> > Addressing.  
> 
> With this:
> This patch is a prerequisite to disable poison by region offset for
> Normalized Addressing.
> 
> With that,
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Alison's request seems sensible to me.  Otherwise looks good.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 
> 
> 

