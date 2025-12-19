Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C52E65D;
	Fri, 19 Dec 2025 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766141725; cv=none; b=Tz33fvHJwK0Uz8vkwqbbDK9b1MDuhoh4D9JZitqGfMsqytLY+z/uEFs2XA4dK4I4CVzWktBI1fgRPX1EaBUpO+yYSNM4zLI/3+xWLFDOV9z8774a9ESb/SDVXJ7WDcSXUbuBM8srwi3VdfHsh8pYn989I5diZBSMzkvEXijLuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766141725; c=relaxed/simple;
	bh=o0HOu8uVSlraU78h5JWalvs/oCNgESq4fsxORrizVOQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ta5dSWdEF0fExYMeQLrN1VyyRRqsKupNVdm1Jya3ppOoBKuuiVXEt8iS/8GHiFmbVmb5xo5KMQDsJk63zHXFNzDvjFyJtCg9Yj1dH7Rmdlr+JMyp4WK8VoakVSmZCaIN1TWPjZcsR7gZaplL1660MAuH9VLGJe4RhjvPqiYpGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXkvC727FzJ46l5;
	Fri, 19 Dec 2025 18:54:47 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 76C3B40569;
	Fri, 19 Dec 2025 18:55:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 10:55:19 +0000
Date: Fri, 19 Dec 2025 10:55:18 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@meta.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <corbet@lwn.net>
Subject: Re: [PATCH v2] Documentation/driver-api/cxl: device hotplug section
Message-ID: <20251219105518.00005ca6@huawei.com>
In-Reply-To: <20251218170747.1278327-1-gourry@gourry.net>
References: <20251218170747.1278327-1-gourry@gourry.net>
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

On Thu, 18 Dec 2025 12:07:47 -0500
Gregory Price <gourry@gourry.net> wrote:

> Describe cxl memory device hotplug implications, in particular how the
> platform CEDT CFMWS must be described to support successful hot-add of
> memory devices.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
> v2: Jonathan's clarifications and diagrams.

One request for a reference given I'm not sure the whole multi-endpoint memory
device thing is going to hang around so that might confuse people reading
this in future - particularly as it isn't something the spec mentions.

With something added there (or a statement that there isn't anything public that
will do the job)

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/Documentation/driver-api/cxl/platform/device-hotplug.rst b/Documentation/driver-api/cxl/platform/device-hotplug.rst
> new file mode 100644
> index 000000000000..617e340bd556
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/device-hotplug.rst

> +
> +Multi-Endpoint Memory Device Present at Boot
> +--------------------------------------------
> +A hot-plug capable CXL memory device, such as one which presents multiple
> +expanders as a single large-capacity device, should report the maximum
> +*possible* capacity for the device at boot. ::
> +
> +                  HB0
> +                  RP0
> +                   |
> +     [Multi-Endpoint Memory Device]

So this is the weird switch as end point thing?   Maybe a reference.
My guess is these will go away as switch and memory device vendors catch
up with the spec, but maybe I'm wrong.

> +              _____|_____
> +             |          |
> +        [Endpoint0]   [Empty]
> +
> +
> +Limiting the size to the capacity preset at boot will limit hot-add support
> +to replacing capacity that was present at boot.


