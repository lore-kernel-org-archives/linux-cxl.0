Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D03002A9;
	Tue, 11 Nov 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874111; cv=none; b=KtIqN3+Ay2sQF1tPGyo5JQXQpGvwBx1v7N3IAuII3AVzJ2T0zUathhIVYPDAcgB5jZHPtprx5ydzCYNk1jWFU8Jv5f0DSDHJIUE9DXLVxeKqED97ZDD3vWecRC2yx7SgDNZuzgcNnlG4MjhtZmZUsyjelY3P6SXqroFiV+tK7F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874111; c=relaxed/simple;
	bh=iAWn7OOW8gWr5ypGaXzXWtobGgClDLw70NXSgJvbSZQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DY9HMkAYVTY0CuicK2g1B8JjtpeEaWPEKu1aLnVwF9TgE9gfRHbyZbVhbe5B1RwRr1AgoiLapFVzGf7BGNlJErXgo/uoYAWmYPBkrLKnqsbDdSUjQHwSfY1saC8At6fqYf+DX401i8EaFsAO6+4vWcxbKOQMXwe92f1ThfeDL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5VSp01DZzHnGkQ;
	Tue, 11 Nov 2025 23:14:50 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 48FF3140122;
	Tue, 11 Nov 2025 23:15:07 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 15:15:06 +0000
Date: Tue, 11 Nov 2025 15:15:05 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 08/14] cxl: Introduce callback for HPA address ranges
 translation
Message-ID: <20251111151505.000034dd@huawei.com>
In-Reply-To: <20251103184804.509762-9-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
	<20251103184804.509762-9-rrichter@amd.com>
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

On Mon, 3 Nov 2025 19:47:49 +0100
Robert Richter <rrichter@amd.com> wrote:

> Introduce a callback to translate an endpoint's HPA range to the
> address range of the root port which is the System Physical Address
> (SPA) range used by a region. The callback can be set if a platform
> needs to handle address translation.
> 
> The callback is attached to the root port. An endpoint's root port can
> easily be determined in the PCI hierarchy without any CXL specific
> knowledge. This allows the early use of address translation for CXL
> enumeration. Address translation is esp. needed for the detection of
> the root decoders. Thus, the callback is embedded in struct
> cxl_root_ops instead of struct cxl_rd_ops.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
