Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A629D1C
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822732; cv=none; b=aacADmHI9YCzv1eKDi+2ZatqAUN+gRWwKDCQEO8q49RdOm1k7LPxVh/ur6nvNUEho9++fGLbJx8/K3r85M4h4z/z7zK+xRBr7oqPuhpIAQRR0bD+Qd6FwEOwyl5j3JqJ3Z4GhSsHLYC2OZrIbbAr7sPqDRoKK2WkJS5Q6uZEdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822732; c=relaxed/simple;
	bh=h717j1pPM+dmnuB78dJ34+L723yB4wJVzBpp75WAGus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNcnFYPdVrAWX3ayHAppMwayw6YoLZTlYdc92WMJlu0NGgypPdUwWdCebfe3NijKtUutWlXAO6ZpWrEFgKWCs3Qh8Nu8Vd+Twbi6aTM28CqDCmhzUylbEs0Rr0v6O0yC9L6509HOamgnfU0DSpovbK54GHL6k8AG9psFw09qIag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46CMIgf6064247;
	Sat, 13 Jul 2024 07:18:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sat, 13 Jul 2024 07:18:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46CMIf83064242
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 13 Jul 2024 07:18:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dfcb0456-dd75-4b9f-9cc8-f0658cd9ce29@I-love.SAKURA.ne.jp>
Date: Sat, 13 Jul 2024 07:18:41 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: Fix uevent_show() vs driver detach race
To: Dan Williams <dan.j.williams@intel.com>, gregkh@linuxfoundation.org
Cc: syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Ashish Sangwan <a.sangwan@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org
References: <172081332794.577428.9738802016494057132.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <172081332794.577428.9738802016494057132.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/13 4:42, Dan Williams wrote:
> @@ -2668,8 +2670,12 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>  	if (dev->type && dev->type->name)
>  		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
>  
> -	if (dev->driver)
> -		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> +	/* Synchronize with module_remove_driver() */
> +	rcu_read_lock();
> +	driver = READ_ONCE(dev->driver);
> +	if (driver)
> +		add_uevent_var(env, "DRIVER=%s", driver->name);
> +	rcu_read_unlock();
>  

Given that read of dev->driver is protected using RCU,

> @@ -97,6 +98,9 @@ void module_remove_driver(struct device_driver *drv)
>  	if (!drv)
>  		return;
>  

where is

	dev->driver = NULL;

performed prior to

> +	/* Synchronize with dev_uevent() */
> +	synchronize_rcu();
> +

this synchronize_rcu(), in order to make sure that
READ_ONCE(dev->driver) in dev_uevent() observes NULL?

>  	sysfs_remove_link(&drv->p->kobj, "module");
>  
>  	if (drv->owner)
> 

