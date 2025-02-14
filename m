Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD538635A;
	Fri, 14 Feb 2025 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551006; cv=none; b=dXwdRjiB9wXvmx2IuxFZt/VBMTTSwA9sx/5o5/l0olOmKnRYIG5qjJXSLLk5UjUMtVX3yMScBjV5bPW2J8UR/ubIEw0HazCqZX4DBQebZSU+HTrOOgYlS9Kl0ML1W694vwG5vJyFnvNWP5mFd8E3hRswedJhikF1MMbU8kwQEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551006; c=relaxed/simple;
	bh=GZCstEErnvCVj/ksKLvDuWb/0SDt+RcmBfnxGXZqdMM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIzycDbQrWM4GxHb91mVAtXTH9UXocbH1ubiNwdzxJdwyc/TgrMmHcgBhXaqcfOc2Xpcr862yJhgjUKPoiIZRY6IgzXsZFGSvitlPgKovzOUfOjGA4RiO7FbY7dQ+xjGcA7eMIJ+XbuwW+YyRovRAG8MLWZSFyREozNy5LzCRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yvd1117t9z67G9M;
	Sat, 15 Feb 2025 00:34:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 990EE1402CB;
	Sat, 15 Feb 2025 00:36:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 17:36:41 +0100
Date: Fri, 14 Feb 2025 16:36:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v3 16/18] cxl/region: Add a dev_err() on missing target
 list entries
Message-ID: <20250214163639.00000bee@huawei.com>
In-Reply-To: <20250211095349.981096-17-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
	<20250211095349.981096-17-rrichter@amd.com>
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

On Tue, 11 Feb 2025 10:53:46 +0100
Robert Richter <rrichter@amd.com> wrote:

> Broken target lists are hard to discover as the driver fails at a
> later initialization stage. Add an error message for this.
> 
> Example log messages:
> 
>   cxl_mem mem1: failed to find endpoint6:0000:e0:01.3 in target list of decoder1.1
>   cxl_port endpoint6: failed to register decoder6.0: -6
>   cxl_port endpoint6: probe: 0
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
Seems reasonable to me as I've also run into fun problems with these
due to setup script bugs...
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
