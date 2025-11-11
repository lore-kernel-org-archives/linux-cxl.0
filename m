Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32715299924;
	Tue, 11 Nov 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873379; cv=none; b=Dj5ymq5kiVuGDP4hZhnTjQ/j1yxOl5Kke1cxHs2u1Z9aQRb/LjtasYW2hhNshWpwdxf+OVjCjNpkR51Hf8i4/8VW0Sidhf5llycT5xAT9IrtHEEr6sq0C54USNJeb21AaKy3VDnT339zc8VqJjaUZuCqvG29F6qE/RCwnIeuXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873379; c=relaxed/simple;
	bh=nIVLyP+b67HrhJamXuI6EbblEjCZNIbd+BMtaaeAqJI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFk8GCoCsemDMlXnKpdtdt5+9F6UqwK9HrmXvRN13p8zVYRJ6C0iplaRFmWKWBjUGHTGHjgCVLDWZZxvZ2la7BZzbJmDArbZiLpQWoxRP84HdVwYPpASwwisugrFA9UdqPM6iZWBJYafRtIPr5TCDAlydLgFgbtdmC2gTmfNr5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5VBj1cvvzHnH9S;
	Tue, 11 Nov 2025 23:02:37 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F4FB140370;
	Tue, 11 Nov 2025 23:02:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 15:02:53 +0000
Date: Tue, 11 Nov 2025 15:02:52 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
	<alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v4 06/14] cxl/region: Separate region parameter setup
 and region construction
Message-ID: <20251111150252.000026fe@huawei.com>
In-Reply-To: <20251103184804.509762-7-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
	<20251103184804.509762-7-rrichter@amd.com>
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

On Mon, 3 Nov 2025 19:47:47 +0100
Robert Richter <rrichter@amd.com> wrote:

> To construct a region, the region parameters such as address range and
> interleaving config need to be determined. This is done while
> constructing the region by inspecting the endpoint decoder
> configuration. The endpoint decoder is passed as a function argument.
> 
> With address translation the endpoint decoder data is no longer
> sufficient to extract the region parameters as some of the information
> is obtained using other methods such as using firmware calls.
> 
> In a first step, separate code to determine the region parameters from
> the region construction. Temporarily store all the data to create the
> region in the new struct cxl_region_context. Once the region data is
> determined and struct cxl_region_context is filled, construct the
> region.
> 
> Patch is a prerequisite to implement address translation. The code
> separation helps to later extend it to determine region parameters
> using other methods as needed, esp. to support address translation.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Other than Dave's comment on not holding the cxlmd, looks good to me.
Another one that will clash with Alejandro's rework for type 2 support
though.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
