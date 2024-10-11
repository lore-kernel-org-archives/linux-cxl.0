Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D1C209662
	for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649705; cv=none; b=NezO5R+8G2E1GL93LdoKxzO2puk1oFRCpE42czISvTIJ22CgXCXTOSKw1i2NWnMtCwIbhXEFPUSdhZ998ahVWmZKXaDrbhtCSm+//uifL4L5Q2RFbxY8lMalsQhIFyyjnDvNxTMBfP6NAa9fCMm9HTkQArMcaETlIyfe54lEfXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649705; c=relaxed/simple;
	bh=ntcgeCURA5ce587yUAKQgoA0Tmx5Ok1EsT51gRWdt8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQuE0d0izzHrEKZ1E0X4tS+lokaLfrqciRRh8ms89Nn8Zi8foaInWsjtS10PVvqIAxnyAQQCgEC+71EDzGSxjzQxXoRf0VP2mjrJWUyxWwMyIpFg87PvWAFIOPwC80P2KMkXERAddRx2QOulJPcwNJdgKocy5B0Yf0CUzQC1aoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bYDx25VQ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bYDx25VQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=7houdCIGUhdA1x+Uffay+F+PIOQHP2RpFB4vPwsx33s=;
	b=bYDx25VQRsmUYz2YQIph2yK7YcisnGKVmGzWbLWLt5Gw4FINweTPvU/1URrpIM
	phmOsNzOmavPA5LMkzQyfy8txWrtvrt92MoMaYmxONvvHhEAYq1UHlqzpgYaMtEO
	OpQYbsVTLaOsWFToPU/sIT5n4QMMtTbzGFMBNBmrpJV4U=
Received: from [192.168.1.26] (unknown [183.195.0.32])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDX_3LHGQln1W_ZAQ--.48413S2;
	Fri, 11 Oct 2024 20:27:53 +0800 (CST)
Message-ID: <e5da0fb3-f7d4-4513-a0ca-cc0099864eef@163.com>
Date: Fri, 11 Oct 2024 20:27:51 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] cxl/port: Fix cxl_bus_rescan() vs
 bus_rescan_devices()
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
 ira.weiny@intel.com
Cc: vishal.l.verma@intel.com, alison.schofield@intel.com,
 linux-cxl@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <172862484920.2150669.7306809902566347902.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Lk Sii <lk_sii@163.com>
In-Reply-To: <172862484920.2150669.7306809902566347902.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDX_3LHGQln1W_ZAQ--.48413S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWkKrW7GryDJry5Gr1rJFb_yoW8tr4xpF
	s5WFWakrW8WryI9ws3Z3yvyFZ8Ww4vy345Wr1xWwn09FnrCw17XFyrK345u34F9rWvka4S
	yr9Fqr1rCa18ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRLNV9UUUUU=
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbiXx11NWcJCfnMAgAAsS

On 2024/10/11 13:34, Dan Williams wrote:
> It turns out since its original introduction, pre-2.6.12,
> bus_rescan_devices() has skipped devices that might be in the process of
> attaching or detaching from their driver. For CXL this behavior is
> unwanted and expects that cxl_bus_rescan() is a probe barrier.
> 

is it relevant with bus_rescan_devices()'s bugs fixed by below link
https://lore.kernel.org/all/20240913-bus_match_unlikely-v2-2-5c0c3bfda2f6@quicinc.com/

which also checks dev->driver within device_lock()'s protection.

> That behavior is simple enough to achieve with bus_for_each_dev() paired
> with call to device_attach(), and it is unclear why bus_rescan_devices()
> took the positition of lockless consumption of dev->driver which is
> racy.
> 
> The "Fixes:" but no "Cc: stable" on this patch reflects that the issue
> is merely by inspection since the bug that triggered the discovery of
> this potential problem [1] is fixed by other means.  However, a stable
> backport should do no harm.
> 
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/port.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e666ec6a9085..b7828b6c7826 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2084,11 +2084,18 @@ static void cxl_bus_remove(struct device *dev)
>  
>  static struct workqueue_struct *cxl_bus_wq;
>  
> -static void cxl_bus_rescan_queue(struct work_struct *w)
> +static int attach_device(struct device *dev, void *data)
>  {
> -	int rc = bus_rescan_devices(&cxl_bus_type);
> +	int rc = device_attach(dev);
> +
> +	dev_vdbg(dev, "rescan: %s\n", rc ? "attach" : "detached");
>  
> -	pr_debug("CXL bus rescan result: %d\n", rc);
> +	return 0;
> +}
> +
> +static void cxl_bus_rescan_queue(struct work_struct *w)
> +{
> +	bus_for_each_dev(&cxl_bus_type, NULL, NULL, attach_device);
>  }
>  
>  void cxl_bus_rescan(void)
> 
> 

