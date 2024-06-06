Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1CA13E02B
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666042; cv=none; b=vBc8k3ST/I4S4+bz00fxTTZYlF/yOb2GUiU4aF0re+eq6W0uzoRzlaDKlFCnUGzPX1AybyQCBbDVs7YjEaFO7NE/SIO6J+fUNwR8kT/U1JlMzExQQvlz2icm/9pXDWtqbvjrlPIkXQcofu4suNqK60Y0d9VRumeEinTGhCCm3PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666042; c=relaxed/simple;
	bh=ZpbOIL3CMjQbIQgIbz7ZbET2bnRrcTZCNZvNviEkuCc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rezJ+BlZWTP0UEZ0VlO5Jyqte/5mHBB8PJSPYgrJ3hgelHFo/F325RWa7t1un0FagBd0i5Wyh9xYI2Ju026OoLqqLJOj7V1i00rcRV0l8DQxYx+uDiLuvA8lVEb1jvMqx0U3t0xb3zNb/wmUf6wSIVE2shQWj85QiF51BI8ywq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvzQ84typz6JBbD;
	Thu,  6 Jun 2024 17:22:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F9C71420FF;
	Thu,  6 Jun 2024 17:27:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 10:27:02 +0100
Date: Thu, 6 Jun 2024 10:27:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>, <qemu-devel@nongnu.org>,
	<ankita@nvidia.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, "Huang
 Ying" <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <imammedo@redhat.com>, <linux-cxl@vger.kernel.org>,
	<linuxarm@huawei.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: Re: [PATCH qemu ] hw/acpi: Fix big endian host creation of Generic
 Port Affinity Structures
Message-ID: <20240606102701.000008de@Huawei.com>
In-Reply-To: <20240605193521-mutt-send-email-mst@kernel.org>
References: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
	<20240605193521-mutt-send-email-mst@kernel.org>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 5 Jun 2024 19:38:18 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jun 05, 2024 at 07:04:55PM +0100, Jonathan Cameron wrote:
> > Treating the HID as an integer caused it to get bit reversed
> > on big endian hosts running little endian guests.  Treat it
> > as a character array instead.
> > 
> > Fixes hw/acpi: Generic Port Affinity Structure Support
> > Tested-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---
> > Richard ran the version posted in the thread on an s390 instance.
> > Thanks for the help!
> > 
> > Difference from version in thread:
> > - Instantiate i in the for loop.
> > 
> > Sending out now so Michael can decide whether to fold this in, or
> > drop the GP series for now from his pull request (in which case
> > I'll do an updated version with this and Markus' docs feedback
> > folded in.)  
> 
> 
> Dropped for now.
> 
> 
> > ---
> >  include/hw/acpi/acpi_generic_initiator.h | 2 +-
> >  hw/acpi/acpi_generic_initiator.c         | 4 +++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
> > index 1a899af30f..5baefda33a 100644
> > --- a/include/hw/acpi/acpi_generic_initiator.h
> > +++ b/include/hw/acpi/acpi_generic_initiator.h
> > @@ -61,7 +61,7 @@ typedef struct PCIDeviceHandle {
> >              uint16_t bdf;
> >          };
> >          struct {
> > -            uint64_t hid;
> > +            char hid[8];
> >              uint32_t uid;
> >          };
> >      };  
> 
> I think there is another issue:
> 
> +        memcpy(&dev_handle.hid, hid, sizeof(dev_handle.hid));
> 
> not nice since there is no check that 8 will hold all of
> +        const char *hid = "ACPI0016";
> and won't access buffer out of range.
> 

I think, in theory, that won't ever happen unless someone is using
an invalid ACPI ID as they 'must' be 8 chars (or a uint64_t which
would also be fine).  A bit of defensive programming seems
sensible though as there are known buggy real firmware's
that have invalid IDs so maybe one day someone will add one
of those to QEMU when we aren't paying attention.

I'll add a sanity check and treat such a value as an error.
It'll also act as documentation of the requirement.

if (strlen(hid) != sizeof(dev_handle.hid)) {
    error_printf("ACPI ID for generic port is not the expected 8 characters");
    exit(-1);	
}



> 
> 
> 
> > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > index 78b80dcf08..f064753b67 100644
> > --- a/hw/acpi/acpi_generic_initiator.c
> > +++ b/hw/acpi/acpi_generic_initiator.c
> > @@ -151,7 +151,9 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
> >          build_append_int_noprefix(table_data, 0, 12);
> >      } else {
> >          /* Device Handle - ACPI */
> > -        build_append_int_noprefix(table_data, handle->hid, 8);
> > +        for (int i = 0; i < sizeof(handle->hid); i++) {
> > +            build_append_int_noprefix(table_data, handle->hid[i], 1);
> > +        }
> >          build_append_int_noprefix(table_data, handle->uid, 4);
> >          build_append_int_noprefix(table_data, 0, 4);
> >      }
> > -- 
> > 2.39.2  
> 
> 

