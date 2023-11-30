Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BC9F4
	for <linux-cxl@vger.kernel.org>; Thu, 30 Nov 2023 00:29:31 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="129524412"
X-IronPort-AV: E=Sophos;i="6.04,237,1695654000"; 
   d="scan'208";a="129524412"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 17:29:29 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 21717D4F6F
	for <linux-cxl@vger.kernel.org>; Thu, 30 Nov 2023 17:29:27 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5F6EF16631
	for <linux-cxl@vger.kernel.org>; Thu, 30 Nov 2023 17:29:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id D336620078941
	for <linux-cxl@vger.kernel.org>; Thu, 30 Nov 2023 17:29:25 +0900 (JST)
Received: from [10.167.220.145] (unknown [10.167.220.145])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 522291A0071;
	Thu, 30 Nov 2023 16:29:25 +0800 (CST)
Message-ID: <766e7de9-8f08-73f2-fc7f-253930f95625@fujitsu.com>
Date: Thu, 30 Nov 2023 16:29:24 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [NDCTL PATCH v2 2/2] cxl: Add check for regions before disabling
 memdev
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 nvdimm@lists.linux.dev
Cc: vishal.l.verma@intel.com, alison.schofield@intel.com
References: <170120423159.2725915.14670830315829916850.stgit@djiang5-mobl3>
 <170120423751.2725915.8152057882418377474.stgit@djiang5-mobl3>
From: =?UTF-8?B?Q2FvLCBRdWFucXVhbi/mm7kg5YWo5YWo?= <caoqq@fujitsu.com>
In-Reply-To: <170120423751.2725915.8152057882418377474.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28028.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28028.005
X-TMASE-Result: 10--3.313700-10.000000
X-TMASE-MatchedRID: P7d3tDo+wQqPvrMjLFD6eJTQgFTHgkhZXQP3X+FD21ATefx8PLB4oAun
	S16vgdV1q5u9Kv3uR4rJkHzMzN7Hijxz8EQpQG12xrDvUMltogRceVBIhfwO9TKIerHAhfYxLYg
	IvATsfpeEju6+OLyeK/MW54P2B2tdzBLzOgP/y9ueAiCmPx4NwLTrdaH1ZWqCZYJ9vPJ1vSDOFi
	BUDxNnDrcClLxx8lxl3QfwsVk0UbvqwGfCk7KUs53t4SBuw4ayddgq4OWSZhO5WHUDb/7kywSMd
	HDYorlSXBgLPtLN50u5LQxQsQ3mhIsfKJ+0UgyMuCLhj+i4hjCbykjAhN1DxgmJ11+/rKxvi5ia
	5+inBSbz0hoYpAuwZnqWp1tbo53zftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0


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
> +	if (cxl_port_decoders_committed(port)) {
>   		log_err(&ml, "%s is part of an active region\n",
>   			cxl_memdev_get_devname(memdev));
> -		return -EBUSY;
> +		if (!param.force)
> +			return -EBUSY;
>   	}
>   
>   	return cxl_memdev_disable_invalidate(memdev);
> 
> 
Hi Dave,
Do you think adding one more prompt message would be more user-friendly?

code:
         if (cxl_port_decoders_committed(port)) {
                 log_err(&ml, "%s is part of an active region\n",
                         cxl_memdev_get_devname(memdev));
                 if (!param.force)
                         return -EBUSY;
                 else
                         log_err(&ml,"Forcing memdev disable with an 
active region\n");
         }

output:
[root@fedora-37-client ndctl]# cxl disable-memdev mem0 -f
cxl memdev: action_disable: mem0 is part of an active region
cxl memdev: action_disable: Forcing memdev disable with an active region
cxl memdev: cmd_disable_memdev: disabled 1 mem
