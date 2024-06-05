Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03219644E
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588952; cv=none; b=I/GHjIHtyPwz75nR7bg5Y5eh2QuTGUruaVxj2O+mXQhE2BDL6ajHPFUsH6ZkMR9SDREQcLMNxOivD1b81gGMxrsWyLsIW+Nt6AU+Xg+NBa2vkq0B7J7GRIbypaBLjzZ4xA5m8alD4KPHCDul0Eyy3XanB6b8ODEjPNCBU3C2u08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588952; c=relaxed/simple;
	bh=ZkWMF417l4GmwGBiBciSBsGgAkn8MuKauDwDLz/q5E0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXqeBuHTeY+Jbw3HuuSUin909586aRdkBaAcJgbXYtJoHxUEuyKaBbuG0iNCN+JeoRdGah7PUvCQfabIzUDjIdKjeIz0gc2u/pGdGBBw/oOdV4IO7IWdgPV4J3dUc5Yqyj041SmjtEsz4p35e+Nwnac4/D0wt9GEtYsfJGeSgH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvQzJ20sYz6K9cq;
	Wed,  5 Jun 2024 20:01:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A5441408F9;
	Wed,  5 Jun 2024 20:02:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 13:02:26 +0100
Date: Wed, 5 Jun 2024 13:02:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Get rid of unused cfmw_list
Message-ID: <20240605130225.00006431@Huawei.com>
In-Reply-To: <20240531061317.865673-1-lizhijian@fujitsu.com>
References: <20240531061317.865673-1-lizhijian@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 31 May 2024 14:13:17 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> There is no user for this member. All '-M cxl-fmw.N' options have
> been parsed and saved to CXLState.fixed_windows.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Hi Li,

Applied to my tree with slight change to patch title
to hw/cxl: Get rid of unused cfmw_list

I aim to send a group of more minor changes like this for upstream
in the next week or so.

Btw, to make it easy to spot QEMU patches in patchwork so that
the kernel maintainers can ignore them - when posting to linux-cxl@vger.kernel.org
[PATCH qemu]
marking for patches is helpful.

Thanks,

Jonathan

> ---
>  hw/cxl/cxl-host.c    | 1 -
>  include/hw/cxl/cxl.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index c5f5fcfd64d0..926d3d3da705 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -335,7 +335,6 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
>      for (it = cfmw_list; it; it = it->next) {
>          cxl_fixed_memory_window_config(state, it->value, errp);
>      }
> -    state->cfmw_list = cfmw_list;
>  }
>  
>  void cxl_machine_init(Object *obj, CXLState *state)
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 75e47b686441..e3ecbef03872 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -43,7 +43,6 @@ typedef struct CXLState {
>      MemoryRegion host_mr;
>      unsigned int next_mr_idx;
>      GList *fixed_windows;
> -    CXLFixedMemoryWindowOptionsList *cfmw_list;
>  } CXLState;
>  
>  struct CXLHost {

