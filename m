Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C72D97B7;
	Thu, 12 Mar 2026 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326110; cv=none; b=itGWdFXyVZhkKT00lUGTlUW2K0u0XLCbQAzsQ9KOBnlKlYx2laJsZckgs+uek58+Xd3clnRTTUKw/Fmi33yH2j0DAY6mB6+yHAuNcY2dXwoE0bCzaEk3XYqk7bxQ4OzEJEjeLaYEERrSSdqjfGRAqRogNc5apqnf6n+Z7XYZdUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326110; c=relaxed/simple;
	bh=RcXFTHeCjEhloIHBRe6yEZvJTq8qqV8nTHMr9SYBtHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9WPTvG7KRE/gHpj0TTMQm1NHpOFEflh800P5ETJBajU8b5V5XrOKa34bjccPsPFgVnc3KOSfR2k7kNd36YLzyOIh1qAXCB5K6Monklgas9LG0iCX4SbMZXqvrsevKvu6T7w+VRqzQQw/xzTtMHZ3bs7bviwMlu0yJNtXTJ6j/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jsU0J/If; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jsU0J/If"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB9AC4CEF7;
	Thu, 12 Mar 2026 14:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773326110;
	bh=RcXFTHeCjEhloIHBRe6yEZvJTq8qqV8nTHMr9SYBtHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jsU0J/IffT2hOrDbN7EaGlQtW1ApDvSwggb7cprhkjLdrLdb5hLDCpHme4cerhsUW
	 di/EpRE43w4Cdf5zTXQkWuJfyqq2bR9WoK98FxMUHqO9XkqMl7EhWc+X0Im3gDzDb0
	 fr4+w+IjGaaeI6doHgqWauKiSdBl+tkVOTFONTek=
Date: Thu, 12 Mar 2026 15:35:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Li Ming <ming.li@zohomail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/7] driver core: Add conditional guard support for
 device_lock()
Message-ID: <2026031258-freefall-cherub-23d2@gregkh>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-1-94fe919a0b87@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-1-94fe919a0b87@zohomail.com>

On Tue, Mar 10, 2026 at 11:57:53PM +0800, Li Ming wrote:
> Introduce conditional guard version of device_lock() for scenarios that
> require conditional device lock holding.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  include/linux/device.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 0be95294b6e6..4fafee80524b 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -911,6 +911,7 @@ static inline void device_unlock(struct device *dev)
>  }
>  
>  DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
> +DEFINE_GUARD_COND(device, _intr, device_lock_interruptible(_T), _RET == 0)
>  
>  static inline void device_lock_assert(struct device *dev)
>  {
> 
> -- 
> 2.43.0
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
