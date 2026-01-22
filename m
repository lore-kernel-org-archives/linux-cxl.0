Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B534F257
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093075; cv=none; b=Hs9lJU/1eiLlbOS7iyI5R+KNw9Mq1HliLjhuewThAbZ81P7Xn749y2sCgAnGgc/K3S5LjSETh7FqGnnZWINGnWlZwKAdXwwhbE6l3XiQORMAnKqNmlj6g4unWQv0Q79YhT101QBVfsLeWsuYnPcuVhS/MzHCY46zmGms/vNeJY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093075; c=relaxed/simple;
	bh=fFzmwTyUcfjOXLmNkxhbCTAl+ggoPjo9SIeM5JINDwo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmRGVF+bAZOs7ezdAGGjwwSWPKaKEekc/4mN0a0etWS8Np30uRIk8B6z7j4sGhn7mdmUl4WE4DZ573J9ry9QmHx75v80XXE/bzyRWBjfipztdIehdpDvXBLDK8BiGgyzNI5XztP/xHX4zi9+EfClyQCQGtpWdEsmJPVee5CsQ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxkMq2wdrzHnGkJ;
	Thu, 22 Jan 2026 22:43:51 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 44E4B40570;
	Thu, 22 Jan 2026 22:44:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 14:44:26 +0000
Date: Thu, 22 Jan 2026 14:44:25 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Subject: Re: [PATCH 5/9] cxl/port: Move dport probe operations to a driver
 event
Message-ID: <20260122144425.000014ca@huawei.com>
In-Reply-To: <20260122033330.1622168-6-dan.j.williams@intel.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
	<20260122033330.1622168-6-dan.j.williams@intel.com>
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
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 21 Jan 2026 19:33:26 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for adding more register setup to the cxl_port_add_dport()
> path (for RAS register mapping), move the dport creation event to a driver
> callback. This achieves two goals, it puts driver operations logically
> where they belong, in a driver, and it obviates the gymnastics of
> DECLARE_TESTABLE() which just makes a mess of grepping for CXL symbols.
> 
> In other words, a driver callback is less of an ongoing maintenance burden
> than this DECLARE_TESTABLE arrangement that does not scale and diminishes
> the grep-ability of the codebase.
> 
> cxl_port_add_dport() moves mostly unmodified from drivers/cxl/core/port.c.
> The only deliberate change is that it now assumes that the device_lock is
> held on entry and the driver is attached (just like cxl_port_probe()).
> 
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Just a small comment on maybe adding some scary sounding docs, or
a struct wrapper to deal with the very specific callback inside
struct cxl_driver.

With at least a comment,
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/cxl/cxl.h                    | 25 +++------
>  tools/testing/cxl/exports.h          | 13 -----
>  drivers/cxl/core/hdm.c               |  6 +--
>  drivers/cxl/core/pci.c               |  8 +--
>  drivers/cxl/core/port.c              | 78 +++++++---------------------
>  drivers/cxl/port.c                   | 60 +++++++++++++++++++++
>  tools/testing/cxl/cxl_core_exports.c | 22 --------
>  tools/testing/cxl/test/mock.c        | 24 +++------
>  tools/testing/cxl/Kbuild             |  2 +
>  9 files changed, 102 insertions(+), 136 deletions(-)
>  delete mode 100644 tools/testing/cxl/exports.h
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6f3741a57932..75ff5f055f7f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -840,8 +840,11 @@ struct cxl_endpoint_dvsec_info {
>  };
>  
>  int devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
> -int __devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
>  int devm_cxl_endpoint_decoders_setup(struct cxl_port *port);
> +void cxl_port_update_decoder_targets(struct cxl_port *port,
> +				     struct cxl_dport *dport);
> +int cxl_port_setup_regs(struct cxl_port *port,
> +			resource_size_t component_reg_phys);
>  
>  struct cxl_dev_state;
>  int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
> @@ -855,6 +858,8 @@ struct cxl_driver {
>  	const char *name;
>  	int (*probe)(struct device *dev);
>  	void (*remove)(struct device *dev);
> +	struct cxl_dport *(*add_dport)(struct cxl_port *port,
> +				       struct device *dport_dev);

Having a single callback in a generic driver struct seems unusual.
Maybe wrap the structure or add some documentation to set expectations.

Probably not the time for it, but why do we have our own probe and remove rather
than using the ones in device_driver?  Maybe we talked about this long
ago, but I can't remember the answer :(


>  	struct device_driver drv;
>  	int id;
>  };

