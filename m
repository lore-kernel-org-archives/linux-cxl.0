Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5227F1D540;
	Fri, 14 Mar 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956401; cv=none; b=qgQecQNrgkHgKYG81sVaa3nriW86kXzcPnP38sB0bVit5Iwmc/KshbW2qw8m4IkZDgPn3MNppsq1wd391kAVtl+WUcILBoGJb0on37WNg0ua38RyedmZBSznXHttVb/neBLMCDPZmcBMaKY1HAn1hWl5nl2tNiOfGrIvl6F6pWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956401; c=relaxed/simple;
	bh=5sGsYuAjRuDkMEybUmn9LmUMY63wqkNJ7b4Zw4tv9eA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zutoqxj4JLGtSuzOJu4G+D57jKYk0W5+gqW0vRnXGVAZ5vmVxPQg1RGXqcapIIW8CS8jC7MxOIGqZCDyUReKe64HnWyP6ziiJJkjF8Xu7pMXJtCzUW/SL6j6a4WicnU/CAManMdp2yJ7QrA7s5NJFAtvhcrjUp38qbIQlf/2ONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDkXB3DjFz6H7cC;
	Fri, 14 Mar 2025 20:42:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 63B91140155;
	Fri, 14 Mar 2025 20:46:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 13:46:36 +0100
Date: Fri, 14 Mar 2025 12:46:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v2 09/15] cxl/region: Use the endpoint's SPA range to
 create a region
Message-ID: <20250314124635.00007352@huawei.com>
In-Reply-To: <20250218132356.1809075-10-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
	<20250218132356.1809075-10-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Feb 2025 14:23:50 +0100
Robert Richter <rrichter@amd.com> wrote:

> To create a region, SPA ranges must be used. With address translation
> the endpoint's HPA range is not the same as the SPA range. Use the
> previously calculated SPA range instead.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
