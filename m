Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048AE15A85A;
	Fri, 19 Dec 2025 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766165300; cv=none; b=BuVC6WRm+XospzYpQcYeIMJczBqHe2XD5NbxfHCqXCeKXhNzbe95kQtuyi1Oq5cEwMJoxdticsKEg3Sbmz9pNtHEVmcUD4ojtl0dDOaKpGwyxPmcTKMMPIoLqbTW5Chv3yy2bBbfA/vEFPlaScm69dIRHs1aw2Y/G5qolGwIaVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766165300; c=relaxed/simple;
	bh=lj7yWJhLosdrP3IbA/4LdJD7bpDpKcinqc+lleIOb28=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYjdmi1W/NNxAzJlbpoIwaRJmJYuEQ8SRaBfMl3wnts2WKpnMvX20gOL5VwTIUOpTcpxAbF2JZCiUit2c2Bs/lvbci/ARtJWdzIIFycyOewNQsB25NDtMd8LvofBGtmv5mri4/DVyHdg0DpFPrqhKpf/dEVrOCFo1t8/mo3wX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXvcb27MJzHnGjf;
	Sat, 20 Dec 2025 01:27:43 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C8EAB40570;
	Sat, 20 Dec 2025 01:28:12 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 17:28:12 +0000
Date: Fri, 19 Dec 2025 17:28:10 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@meta.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <corbet@lwn.net>, <rakuram.e96@gmail.com>,
	<alucerop@amd.com>
Subject: Re: [PATCH v3 1/2] Documentation/driver-api/cxl: BIOS/EFI
 expectation update
Message-ID: <20251219172810.00002e70@huawei.com>
In-Reply-To: <20251219170538.1675743-2-gourry@gourry.net>
References: <20251219170538.1675743-1-gourry@gourry.net>
	<20251219170538.1675743-2-gourry@gourry.net>
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

On Fri, 19 Dec 2025 12:05:37 -0500
Gregory Price <gourry@gourry.net> wrote:

> Add a snippet about what Linux expects BIOS/EFI to do (and not
> to do) to the BIOS/EFI section.
> 
> Suggested-by: Alejandro Lucero Palau <alucerop@amd.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>

Nice.  Best of all I can blame you if our bios folk moan at me :)

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  .../driver-api/cxl/platform/bios-and-efi.rst  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> index a9aa0ccd92af..9034c206cf8e 100644
> --- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> +++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> @@ -29,6 +29,26 @@ at :doc:`ACPI Tables <acpi>`.
>     on physical memory region size and alignment, memory holes, HDM interleave,
>     and what linux expects of HDM decoders trying to work with these features.
>  
> +
> +Linux Expectations of BIOS/EFI Software
> +=======================================
> +Linux expects BIOS/EFI software to construct sufficient ACPI tables (such as
> +CEDT, SRAT, HMAT, etc) and platform-specific configurations (such as HPA spaces
> +and host-bridge interleave configurations) to allow the Linux driver to
> +subsequently configure the devices in the CXL fabric at runtime.
> +
> +Programming of HDM decoders and switch ports is not required, and may be
> +deferred to the CXL driver based on admin policy (e.g. udev rules).
> +
> +Some platforms may require pre-programming HDM decoders and locking them
> +due to quirks (see: Zen5 address translation), but this is not the normal,
> +"expected" configuration path.  This should be avoided if possible.
> +
> +Some platforms may wish to pre-configure these resources to bring memory
> +up without requiring CXL driver support.  These platform vendors should
> +test their configurations with the existing CXL driver and provide driver
> +support for their auto-configurations if features like RAS are required.
> +
>  UEFI Settings
>  =============
>  If your platform supports it, the :code:`uefisettings` command can be used to

