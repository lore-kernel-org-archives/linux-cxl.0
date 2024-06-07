Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5A73449;
	Fri,  7 Jun 2024 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749014; cv=none; b=ZF+9khoLQEvNTjC46l4fo9hMwCz7db3Eh9u18sfVoZmidXcW3LbzX+vs+J9IoFUHp+OT8Oi1cccDh6TyLlM0Qy5a81JJrZtc3/ESht/+hy34vi8s68/49JnEw55nBccOPfn79BeYIOP7nLxml7Gk+pSf2Uk4z5bzyODBKxtskkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749014; c=relaxed/simple;
	bh=0TnUzUxvZQdTx9CuUgse6TVT1R8oY0fk7XreHm3feVc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YU+RSIRKceSdFOVrjQ5sY+PHmBNYi9YPnbJVQC+lm10FQMwf83ZyJ2IfTC4/OsMAPnCQATRMfYNxlEBs0nOgOO+KKI5nxAaPd/+z7IWh02N3WW5kfuzyHoSSKREZ/qLVxMdVRJodL9jNjOgg7CWtswEpriGGoAa9Jtq8ZPYtehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwZ5L2x5Vz67Zdq;
	Fri,  7 Jun 2024 16:25:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E2D4140B2F;
	Fri,  7 Jun 2024 16:30:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 09:30:07 +0100
Date: Fri, 7 Jun 2024 09:30:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Jeff Johnson <quic_jjohnson@quicinc.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] cxl: add missing MODULE_DESCRIPTION() macros
Message-ID: <20240607093006.00004335@Huawei.com>
In-Reply-To: <6662497490e90_2177294e4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240603-md-drivers-cxl-v1-1-f2940f5c0836@quicinc.com>
	<20240604170445.00005c67@Huawei.com>
	<362fccea-707f-4430-8da3-8acc6ac5fbe9@quicinc.com>
	<20240606151521.000018fd@Huawei.com>
	<b3405ab7-b322-4ce9-9dfa-efb52438383a@quicinc.com>
	<6662497490e90_2177294e4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 6 Jun 2024 16:42:44 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jeff Johnson wrote:
> [..]
> > >> This I just made up from the others since config CXL_PORT doesn't have a menu
> > >> description or help text and the .c file begins with:
> > >>  * DOC: cxl port  
> > > 
> > > "CXL: Port Support"
> > > 
> > > Not that informative, but I can't immediately think of better text.  
> 
> How about "CXL: Port enumeration and services"
> 

LGTM
