Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCF64D2EEF;
	Tue, 19 May 2026 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194754; cv=none; b=T7lDbgXf+fcQCRrJ1bYmaFF0ZhhYJZ+kzBl3x1sBNVQ5COs81VhKSTdpA4t1dLV9/kgC5SAo/sb13l6yYbymlnMOWQthTmrGT86lM9zDgDCgWohlwDerktkvokN/IDWsMZITsf64D8r7uJK/8LNLTovFcgSt44v0DZZWfXb7zLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194754; c=relaxed/simple;
	bh=C87IXNJFNuffOPo6j/clO/ETCIoredweTuvFWS9kwRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkDdB4KbKg6PCWHNhaM04FM5Cy1RvPa/zEoPkh9BrtSYXFTOWgI04GH88xzoQzehjEwnPkDlGKo5xyXbNjqwOgokAiA6tPg6iryqA83EBzc+LgYuiNJXDaQ3HvyPSn87vGhDFtnU0HPkc3NEF6ZeaJqAYGJpQxwm3Y58bpO+vfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW0J9gop; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW0J9gop"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A93C2BCB3;
	Tue, 19 May 2026 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779194753;
	bh=C87IXNJFNuffOPo6j/clO/ETCIoredweTuvFWS9kwRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UW0J9gop/eSaKgskULyG7KraU52ARclJ4PYF99h/cA5Wzh+vAgGwxL8PUttXl44vh
	 ZchTvo6DGmDuvwTAa5tc7i1d/C+5J3EKbUWPaQM5RhSyTOg5CUKceMw3mYLoRAIpOa
	 L88HsPbmxNr1Jg4mHXobck9L1c5F934hcZKhvNev/dEoeOd/66+uQKNAWMXh/6zt2l
	 IG8ac7n+8FsHKIUN7s3nilp6974Y7d4bpw+9QTjRBmOS6tMBi9do6TvDFg7AluN1/5
	 d1yKmH7rSneQKbcRbDtSUC+eMdhJumP5DRiQLSkl7z/r8sYzsepl1rPnfrlF9LJ/Qq
	 sYoaajKqzFcNw==
Date: Tue, 19 May 2026 13:45:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>
Cc: <alwilliamson@nvidia.com>, <skolothumtho@nvidia.com>,
 <ankita@nvidia.com>, <mst@redhat.com>, <imammedo@redhat.com>,
 <anisinha@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <shannon.zhaosl@gmail.com>, <jonathan.cameron@huawei.com>,
 <fan.ni@samsung.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <marcel.apfelbaum@gmail.com>,
 <clg@redhat.com>, <cohuck@redhat.com>, <dan.j.williams@intel.com>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
 <zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-cxl@vger.kernel.org>,
 <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: Re: [RFC 2/9] cxl: Add preserve_config to pxb-cxl OSC method
Message-ID: <20260519134539.1b11ace4@jic23-huawei>
In-Reply-To: <20260427181235.3003865-3-mhonap@nvidia.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
	<20260427181235.3003865-3-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 23:42:28 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> Before this patch, pxb-cxl bridges had no _DSM method at all. When the
> OS called _DSM on a CXL host bridge, ACPI returned an error and the OS
> defaulted to reassigning resources across suspend/resume. On machines
> where firmware pre-commits the HDM decoder, that reassignment breaks the
> DPA mapping.

Ah. Ok. So it's suspend / resume that is causing trouble. I wasn't aware
PCI reenumerated on that as opposed to boot. I surprised more doesn't
break.  Make sure to call that out in the cover letter as the impression
I got was the problem was initial enumeration.

Mind you I'm still confused. Why is CXL.mem path affected?  That's
nothing to do with PCI enumeration.

Jonathan

> 
> Wire preserve_config through GPEXConfig into build_cxl_osc_method() so
> pxb-cxl host bridges get a _DSM method that signals the OS to keep
> resource assignments stable when needed. The _DSM function 5 (preserve
> firmware PCI configuration) is the mechanism used to convey this.
> 
> build_pci_host_bridge_dsm_method() is promoted from static to exported
> so cxl.c can call it without duplicating the AML.
> 
> The x86 build_cxl_osc_method() call site passes false since x86 does
> not use firmware-committed HDM decoders.
> 
> build_cxl_osc_method is renamed to acpi_dsdt_add_cxl_host_bridge_methods
> The function now appends both the CXL _OSC method and the _DSM method,
> so its old name is misleading. Renamed it to match the pxb-pcie analogue
> acpi_dsdt_add_host_bridge_methods(), making the two root bridge code
> paths symmetric. No AML change.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  hw/acpi/cxl-stub.c         | 2 +-
>  hw/acpi/cxl.c              | 4 +++-
>  hw/i386/acpi-build.c       | 2 +-
>  hw/pci-host/gpex-acpi.c    | 5 +++--
>  include/hw/acpi/cxl.h      | 2 +-
>  include/hw/pci-host/gpex.h | 1 +
>  6 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/acpi/cxl-stub.c b/hw/acpi/cxl-stub.c
> index 15bc21076b..d7c6731975 100644
> --- a/hw/acpi/cxl-stub.c
> +++ b/hw/acpi/cxl-stub.c
> @@ -6,7 +6,7 @@
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/cxl.h"
>  
> -void build_cxl_osc_method(Aml *dev)
> +void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool preserve_config)
>  {
>      g_assert_not_reached();
>  }
> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> index f92f7fa3d5..b32740a3e3 100644
> --- a/hw/acpi/cxl.c
> +++ b/hw/acpi/cxl.c
> @@ -23,6 +23,7 @@
>  #include "hw/pci/pci_host.h"
>  #include "hw/cxl/cxl.h"
>  #include "hw/cxl/cxl_host.h"
> +#include "hw/pci-host/gpex.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/aml-build.h"
> @@ -320,11 +321,12 @@ static Aml *__build_cxl_osc_method(void)
>      return method;
>  }
>  
> -void build_cxl_osc_method(Aml *dev)
> +void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool preserve_config)
>  {
>      aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>      aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>      aml_append(dev, aml_name_decl("SUPC", aml_int(0)));
>      aml_append(dev, aml_name_decl("CTRC", aml_int(0)));
>      aml_append(dev, __build_cxl_osc_method());
> +    aml_append(dev, build_pci_host_bridge_dsm_method(preserve_config));
>  }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f622b91b76..f66ec8ed24 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1013,7 +1013,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                  aml_append(aml_pkg, aml_eisaid("PNP0A08"));
>                  aml_append(aml_pkg, aml_eisaid("PNP0A03"));
>                  aml_append(dev, aml_name_decl("_CID", aml_pkg));
> -                build_cxl_osc_method(dev);
> +                acpi_dsdt_add_cxl_host_bridge_methods(dev, false);
>              } else if (pci_bus_is_express(bus)) {
>                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
>                  aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 7de57bbc46..247bd78152 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -52,7 +52,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>      }
>  }
>  
> -static Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
> +Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
>  {
>      Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
>      Aml *UUID, *ifctx, *ifctx1, *buf;
> @@ -204,7 +204,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>              aml_append(dev, aml_name_decl("_CRS", crs));
>  
>              if (is_cxl) {
> -                build_cxl_osc_method(dev);
> +                acpi_dsdt_add_cxl_host_bridge_methods(dev,
> +                                                      cfg->preserve_config);
>              } else {
>                  /* pxb bridges do not have ACPI PCI Hot-plug enabled */
>                  acpi_dsdt_add_host_bridge_methods(dev, true,
> diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
> index 8f22c71530..6fe6c9c58d 100644
> --- a/include/hw/acpi/cxl.h
> +++ b/include/hw/acpi/cxl.h
> @@ -24,7 +24,7 @@
>  void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
>                      BIOSLinker *linker, const char *oem_id,
>                      const char *oem_table_id, CXLState *cxl_state);
> -void build_cxl_osc_method(Aml *dev);
> +void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool preserve_config);
>  void build_cxl_dsm_method(Aml *dev);
>  
>  #endif
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index a7c2e2edf3..e5c2ebef78 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -73,6 +73,7 @@ struct GPEXHost {
>  int gpex_set_irq_num(GPEXHost *s, int index, int gsi);
>  
>  void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg);
> +Aml *build_pci_host_bridge_dsm_method(bool preserve_config);
>  void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq);
>  
>  #define PCI_HOST_PIO_BASE               "x-pio-base"

