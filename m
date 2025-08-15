Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468B2746C
	for <linux-cxl@vger.kernel.org>; Fri, 15 Aug 2025 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755263729; cv=none; b=c6UVqRhVpNie1N1dTjgVbOdDYY6w8CEOMlN+1ZO3CQ75T1IFAzPnvec1hOzr95HFevuIVHdRhHjowIU3G37ayU5lODZ/5WNctqPqwOVSdyjI0zY5Hf8erm8XcswpLWiZP+iB3r74Y1M5zCjJLOC2A8GZDu59mAtRzMd8wNnzFKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755263729; c=relaxed/simple;
	bh=h0sep7ZHVxyCPw2tPdM7WG1HrNBQfWCfjKfVGGrESDo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTqDeyRLnoOAAyQsCLhITH/eoO45PflfbL8xn4MOpNIiuymy4QpGA4gU71OpimGP8whBTfyJ6Sw38ujPOk0BDrkDiMx1TLS4RPmAvu0RUYGByNqLTkz5+NdefSh8yFkxOkTUno/gXx1z+Ak0y06Q7hpDIwB+n8i5lqeXvgXh808=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3Mss0tm1z6L5PJ;
	Fri, 15 Aug 2025 21:10:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B49F1404C5;
	Fri, 15 Aug 2025 21:15:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 15:15:23 +0200
Date: Fri, 15 Aug 2025 14:15:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v8 11/11] tools/testing/cxl: Add decoder save/restore
 support
Message-ID: <20250815141521.00003992@huawei.com>
In-Reply-To: <20250814222151.3520500-12-dave.jiang@intel.com>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
	<20250814222151.3520500-12-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 14 Aug 2025 15:21:51 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Record decoder values at init and mock_decoder_commit() time, and
> restore them at the next invocation of mock_init_hdm_decoder(). Add 2
> attributes to the cxl_test "cxl_acpi" device to optionally flush the
> cache of topology decoder values, or disable updating the decoder at
> mock_decoder_reset() time.
> 
> This enables replaying a saved decoder configuration when re-triggering
> a topology scan by re-binding the cxl_acpi driver to "cxl_acpi.0" (the
> cxl_test emulation of an ACPI0017 instance).
> 
>     # modprobe cxl_test
>     # cxl list -RB -b cxl_test -u
>     {
>       "bus":"root3",
>       "provider":"cxl_test",
>       "regions:root3":[
>         {
>           "region":"region5",
>           "resource":"0xf010000000",
>           "size":"512.00 MiB (536.87 MB)",
>           "type":"ram",
>           "interleave_ways":2,
>           "interleave_granularity":4096,
>           "decode_state":"commit"
>         }
>       ]
>     }
>     # echo 1 > /sys/bus/platform/devices/cxl_acpi.0/decoder_registry_reset_disable
>     # echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/unbind
>     # cxl list -RB -b cxl_test -u
>     # echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/bind
>     # cxl list -RB -b cxl_test -u
>     {
>       "bus":"root3",
>       "provider":"cxl_test",
>       "regions:root3":[
>         {
>           "region":"region5",
>           "resource":"0xf010000000",
>           "size":"512.00 MiB (536.87 MB)",
>           "type":"ram",
>           "interleave_ways":2,
>           "interleave_granularity":4096,
>           "decode_state":"commit"
>         }
>       ]
>     }
> 
> [dj: Added support for delayed dport initialization ]
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Authorship wrong, or a Co-dev missing?  Was expecting to see  a From: Dan...


> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> - Will have a cxl-replay test script in CXL CLI package
> - This allowed me to test assembly and replay for manually created CXL regions
> ---
>  tools/testing/cxl/test/cxl.c | 300 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 298 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 2d50193d10fe..e0da2a48d2a8 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -47,6 +47,9 @@ struct platform_device *cxl_mem_single[NR_MEM_SINGLE];
>  static struct platform_device *cxl_rch[NR_CXL_RCH];
>  static struct platform_device *cxl_rcd[NR_CXL_RCH];
>  
> +static DEFINE_XARRAY(decoder_registry);
> +static bool decoder_registry_reset_disable;
> +
>  static inline bool is_multi_bridge(struct device *dev)
>  {
>  	int i;
> @@ -671,6 +674,164 @@ static int map_targets(struct device *dev, void *data)
>  	return 0;
>  }
>  
> +static unsigned long cxld_registry_index(struct cxl_decoder *cxld)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +
> +	/*
> +	 * Upper nibble of a kernel pointer is 0xff, chop that to make

Very unlikely a nibble is 0xff, more likely 0xf unless you x86 folk have
8 bit nibbles :)

> +	 * space for a cxl_decoder id which should be less than 128
> +	 * given decoder count is a 4-bit field.

If it's a 4 bit field, how can it be greater than 15?
Maybe I need more coffee.

> +	 *
> +	 * While @port is reallocated each enumeration, @port->uport_dev
> +	 * is stable.
> +	 */
> +	dev_WARN_ONCE(&port->dev, cxld->id >= 128,
> +		      "decoder id:%d out of range\n", cxld->id);
> +	return (((unsigned long) port->uport_dev) << 4) | cxld->id;
> +}

