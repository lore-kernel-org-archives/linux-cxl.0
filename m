Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B3C197
	for <linux-cxl@vger.kernel.org>; Mon, 27 Nov 2023 22:35:23 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="141219573"
X-IronPort-AV: E=Sophos;i="6.04,233,1695654000"; 
   d="scan'208";a="141219573"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 15:35:21 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2B271D618E
	for <linux-cxl@vger.kernel.org>; Tue, 28 Nov 2023 15:35:19 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5D8D1D5EA1
	for <linux-cxl@vger.kernel.org>; Tue, 28 Nov 2023 15:35:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id DA5ED4119F
	for <linux-cxl@vger.kernel.org>; Tue, 28 Nov 2023 15:35:17 +0900 (JST)
Received: from [10.167.220.145] (unknown [10.167.220.145])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 5AC131A0070;
	Tue, 28 Nov 2023 14:35:17 +0800 (CST)
Message-ID: <7eaf1057-2caf-8ec9-8b79-22ad4976ef76@fujitsu.com>
Date: Tue, 28 Nov 2023 14:35:16 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [NDCTL PATCH 2/2] cxl: Add check for regions before disabling
 memdev
To: Dave Jiang <dave.jiang@intel.com>, vishal.l.verma@intel.com
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
References: <169645730392.624805.16511039948183288287.stgit@djiang5-mobl3>
 <169645731012.624805.15404457479294344934.stgit@djiang5-mobl3>
From: =?UTF-8?B?Q2FvLCBRdWFucXVhbi/mm7kg5YWo5YWo?= <caoqq@fujitsu.com>
In-Reply-To: <169645731012.624805.15404457479294344934.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28024.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28024.005
X-TMASE-Result: 10--6.776000-10.000000
X-TMASE-MatchedRID: 9xvWjox81uOPvrMjLFD6eJTQgFTHgkhZXQP3X+FD21ATefx8PLB4oE1N
	J2MN+nPka+o/S6GsElBTtuW5X/TasERV7C9ojOZ1EVuC0eNRYvKlR2Q+0FuebvmrkkH6JvZBPrT
	BAt3E1ioXjQchKpIrqqnmDHpokNZJO4kcA8kjsz/v7rnu8XKYw8E5XPQnBzGXq8KsbROd9VR3Ib
	SSOjBC458i2lZ/9LH/yZB8zMzex4oI72eZSqlThNjoQZHeT+6K3hng3KTHeTZ00vMXkV+kqIY2R
	oj+9G1t4vM1YF6AJbZFi+KwZZttL1QAAzJkx/SoudR/NJw2JHcNYpvo9xW+mI6HM5rqDwqtGdvD
	LEXul9A6HqTgIcCmlRftYM2uSlFOKiervPkw0QZpFy/hy7LLEx+PkXEi09h7k0Kz9G8k31l7DPy
	xRFcy9Y9T4jYMgd/igokLZRKLKVGdC4HNoe3rP7Iyum16+pyZ1elfyC1yu6+FK45C57CBPA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0


> Add a check for memdev disable to see if there are active regions present
> before disabling the device. This is necessary now regions are present to
> fulfill the TODO that was left there. The best way to determine if a
> region is active is to see if there are decoders enabled for the mem
> device. This is also best effort as the state is only a snapshot the
> kernel provides and is not atomic WRT the memdev disable operation. The
> expectation is the admin issuing the command has full control of the mem
> device and there are no other agents also attempt to control the device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   cxl/memdev.c |   14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/cxl/memdev.c b/cxl/memdev.c
> index f6a2d3f1fdca..314bac082719 100644
> --- a/cxl/memdev.c
> +++ b/cxl/memdev.c
> @@ -373,11 +373,21 @@ static int action_free_dpa(struct cxl_memdev *memdev,
>   
>   static int action_disable(struct cxl_memdev *memdev, struct action_context *actx)
>   {
> +	struct cxl_endpoint *ep;
> +	struct cxl_port *port;
> +
>   	if (!cxl_memdev_is_enabled(memdev))
>   		return 0;
>   
> -	if (!param.force) {
> -		/* TODO: actually detect rather than assume active */
> +	ep = cxl_memdev_get_endpoint(memdev);
> +	if (!ep)
> +		return -ENODEV;
> +
> +	port = cxl_endpoint_get_port(ep);
> +	if (!port)
> +		return -ENODEV;
> +
> +	if (cxl_port_decoders_committed(port) && !param.force) {
>   		log_err(&ml, "%s is part of an active region\n",
>   			cxl_memdev_get_devname(memdev));
>   		return -EBUSY;
> 
> 
Hi Dave,

Based on my understanding of the logic in the "disable_region" and 
"destroy_region" code, in the code logic of 'disable-region -f,' after 
the check, it proceeds with the offline operation. In the code logic of 
'destroy-region -f,' after the check, it performs a disable operation on 
the region. For the 'disable-memdev -f' operation, after completing the 
check, is it also necessary to perform corresponding operations on the 
region(such as disabling region/destroying region) before disabling memdev?

