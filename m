Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D92EAB79;
	Tue, 11 Nov 2025 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875267; cv=none; b=uS+RhAVXU3zQOJb7h2jq99D9exDZDxlVVs24okLpaZfgCD6PfU056FaVL7mVI/PDkQZnBvV9LOOSNFX0OVyqk0rUGXswOEmw376K7vC9aKM+PKCNWn2sq/l6bZu0HbN6Eutk28XX2bCW3wbZI3zLGw1CwZpcB8jw8eWgONNaWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875267; c=relaxed/simple;
	bh=EfcOFx+6b5UdaQZmWZK0d+vJUNy2tN7vw7Jwnf0NTGk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBEdxr7Xtl1+1AMjyRb76NgQqGOWTiUl57w9fq4uoZGi8NpNUG9/mgTx7SAMXuGyo8fC9yjjrIMBzD/U4HGfnLCVD9FPpXtz4WaK6amxHv0ojthgEi13NslMEdGMpJlDtUaWcXaaLsUrAIyd6oTXSe9f3XnznfAdHzPI+KNwRZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5Vv02RRxzHnGkM;
	Tue, 11 Nov 2025 23:34:04 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A136D140122;
	Tue, 11 Nov 2025 23:34:21 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 15:34:20 +0000
Date: Tue, 11 Nov 2025 15:34:19 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 12/14] cxl: Simplify cxl_rd_ops allocation and
 handling
Message-ID: <20251111153419.00006931@huawei.com>
In-Reply-To: <20251103184804.509762-13-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
	<20251103184804.509762-13-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 3 Nov 2025 19:47:53 +0100
Robert Richter <rrichter@amd.com> wrote:

> A root decoder's callback handlers are collected in struct cxl_rd_ops.
> The structure is dynamically allocated, though it contains only a few
> pointers in it. This also requires to check two pointes to check for
> the existance of a callback.
> 
> Simplify the allocation, release and handler check by embedding the
> ops statical in struct cxl_root_decoder.
> 
> Implementation is equivalent to how struct cxl_root_ops handles the
> callbacks.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Given we aren't picking between big sets of static const ops but
instead just 2 (in which case the indirection would be a good idea),
I'm fine with this as a simplication over dynamic allocation.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
