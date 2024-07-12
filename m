Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6701140E58;
	Fri, 12 Jul 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774611; cv=none; b=kdG5yO5VKDjqk65cNKjKFZuLVNyPw9L8RP4bAGPIMX3t0AYWDpIb9YkbUw7CX4zjh0UPO2tB8WdTR05LuRDCQVoYAN2nOPUdIoQQ+ME4SGjVVsXwVS7hEFGeKRH/D3MwaJzql8+7Kds6M56BnA4vV86+SO5XxpNo6TxbHbJOxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774611; c=relaxed/simple;
	bh=bSq7Nc3adHyPGYFGHIoS1jiGq8sFkJXkLR8MDpxbgrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR2yoYUXxk6+C+93LhizcVrkFH9Rd8RkJlga5e/QhQDhFCeFS9gb7+nvulV8uTxHvHzbzPJlzTp09WtQFOcOBImbna+h9fWNJrmWQYQPeWAbLpdJJX8ZJQeciSX83/n40h6UsMq72T1T43A2lUDe9ygt9sUyrMRJjbgrEfwdaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oxvxumuJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oxvxumuJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14BDC4AF09;
	Fri, 12 Jul 2024 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720774611;
	bh=bSq7Nc3adHyPGYFGHIoS1jiGq8sFkJXkLR8MDpxbgrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxvxumuJM4jYPgzAfBRxcGx2E7VS/yZWNuTEj+yCPEVXWKm0ArJYl5sWU0K8cNSCj
	 wlCByUAAl8Y2yIvZDvHpVdIV8r2nJfs5YocWA1n+zIzLgJxHJvYfQvVbV5wbLHAjUB
	 J+YkZ3sUJzQl1WC6y7bnG0xQll2AadnJEADRsr3M=
Date: Fri, 12 Jul 2024 10:56:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-kernel@vger.kernel.org,
	Rafael J Wysocki <rafael@kernel.org>,
	Eugeniu Rosca <eugeniu.rosca@bosch.com>,
	syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com,
	Ashish Sangwan <a.sangwan@samsung.com>,
	Namjae Jeon <namjae.jeon@samsung.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] drivers: core: synchronize really_probe() and
 dev_uevent()
Message-ID: <2024071227-surname-satirical-1184@gregkh>
References: <20240513050634.3964461-1-dirk.behme@de.bosch.com>
 <669073b8ea479_5fffa294c1@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <669073b8ea479_5fffa294c1@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Jul 11, 2024 at 05:07:21PM -0700, Dan Williams wrote:
> Dirk Behme wrote:
> > Synchronize the dev->driver usage in really_probe() and dev_uevent().
> > These can run in different threads, what can result in the following
> > race condition for dev->driver uninitialization:
> 
> This fix introduces an ABBA deadlock scenario via the known antipattern
> of taking the device_lock() within device attributes that are removed
> while the lock is held.

Ugh, yes :(

device attributes should not be taking that lock, don't we have a
different call for an attribute that will be removing itself?

> Lockdep splat below. I previously reported this on a syzbot report
> against nvdimm subsytems with a more complicated splat [1], but this one
> is more straightforward.
> 
> Recall that the reason this lockdep report is not widespread is because
> CXL and NVDIMM are among the only subsystems that add lockdep coverage
> to device_lock() with a local key.
> 
> [1]: http://lore.kernel.org/667a2ae44c0c0_5be92947e@dwillia2-mobl3.amr.corp.intel.com.notmuch
> 
> One potential hack is something like this if it is backstopped with
> synchronization between unregistering drivers from buses relative to
> uevent callbacks for those buses:
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 2b4c0624b704..dfba73ef39af 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2640,6 +2640,7 @@ static const char *dev_uevent_name(const struct kobject *kobj)
>  static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>  {
>         const struct device *dev = kobj_to_dev(kobj);
> +       struct device_driver *driver;
>         int retval = 0;
>  
>         /* add device node properties if present */
> @@ -2668,8 +2669,14 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>         if (dev->type && dev->type->name)
>                 add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
>  
> -       if (dev->driver)
> -               add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> +       /*
> +        * While it is likely that this races driver detach, it is
> +        * unlikely that any driver attached with this device is racing being
> +        * freed relative to a uevent for the same device
> +        */
> +       driver = READ_ONCE(dev->driver);
> +       if (driver)
> +               add_uevent_var(env, "DRIVER=%s", driver->name);
>  
>         /* Add common DT information about the device */
>         of_device_uevent(dev, env);
> 

I'll take this patch for now if you want to also include the removal of
the lock patch that caused your splat.

thanks,

greg k-h
