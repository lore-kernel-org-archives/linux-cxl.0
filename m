Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113362BD59C;
	Sun,  8 Feb 2026 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770553281; cv=pass; b=rvhYCDJLQczFM3IBBzLQudutSfuEhYDzCC+ey6bkwKkCrvu8ViAbLHgzpL5TcTHQbieItprofaBW/pCcL5jz5PkRMX9Ptt59uSGK5duizHS2H2y6GaZVI7lutLltQatBX9sb2PZrAth0Ja/zO7zlSSpvyqnHhveIxBjhKigQe5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770553281; c=relaxed/simple;
	bh=6r6DAEN/39KnqCDskzMPUi4wTxPK3YY25B1anzgDru0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQx+a4DJouqoQt9frL0NaQ6e3xkscQFa//Xxt2gf1VMlJj8N6e7IatnaqwBVJPlk2nGoEX3kdHnZHrOaoGlNV0ZB0wqTRw0AQIdAW8MPftR6ixC6iEHcUZbIvy2krfChyLCUc48GnJkGoL+2ZsBoxiH4jo4kHogWgHNt4jSOScw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=a66U0l6o; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="a66U0l6o"
ARC-Seal: i=1; a=rsa-sha256; t=1770553263; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a8qvF/leuNRa/BLf8AkwjA+AJnODx04iDadKG5d9EE3pY8x32zCKEMDLpjOkZvsr8LdSyACZqt085sI1KGpCBnc83QMWm8lHsy9HXHUEsJjezqA3ybs8gxrvCpY66L7LYT7aNKrpP9BjxwCOokB4jSM8mA4WvmxFlQY4RFN1BOQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770553263; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iz6FxdXJRThUCNfOaoMuz5IxWuRtBLYncqDIig2O9uo=; 
	b=YywNGr56kG9jpuFwWlvnZPXPy/YACkJHa4H7tQarYrpsFPk8B+/XJQO7rQPoXSdvMYNWtPUPzgbKc68Mjw/K1YfAsNUDtz21un1Ija1aMxEiaw2GhfabO/DndYjmKiMlkURdje2xIudnvT9H6onXo935Rzy3gUjnZ124cPUfmdA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770553263;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=iz6FxdXJRThUCNfOaoMuz5IxWuRtBLYncqDIig2O9uo=;
	b=a66U0l6o5zTyFUZPpdYcuKNbCuR6h0T05gSRlkNAhmsnPrspxokM+4K8iygzNkQN
	UbCcCI8iPK8ATPU3XQC+idnKT3DzXY2fezfygNAup2PT4y7e6sm2NR3bb9VKBZzhBGf
	z1k8TVb31ZSeq3AQZpwAaKWr34Pgn0Dalw7rWQEA=
Received: by mx.zohomail.com with SMTPS id 177055326154671.29381060272215;
	Sun, 8 Feb 2026 04:21:01 -0800 (PST)
Message-ID: <dd172105-e152-4973-ad7f-0ed37ed0b18e@zohomail.com>
Date: Sun, 8 Feb 2026 20:20:55 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cxl/port: Hold port host lock while dport adding.
To: dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
References: <20260207133512.306128-1-ming.li@zohomail.com>
 <20260207133512.306128-2-ming.li@zohomail.com>
 <6987763fea2ab_125f100f5@dwillia2-mobl4.notmuch>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <6987763fea2ab_125f100f5@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011228b16293364ffde8ef799b1ae70000474c061db90f8767328263e1fa270ab3ecfdf54dba6d0978b286:zu08011227d709f3d184f2fc86c51e55b10000d06a8bf1f9a8457dd1861a32279c91c84b40b8a796e8a54a15:rf080112324718cfc837197b6c76e0b5c40000a62d993432a96987d7817093afba4719c49763ad652aaf80c88d1128b2d2521dc2eea548:ZohoMail
X-ZohoMailClient: External


在 2026/2/8 01:28, dan.j.williams@intel.com 写道:
> Li Ming wrote:
[...]
> +static struct device *to_port_host(struct cxl_port *port)
> +{
> +	struct cxl_port *parent = parent_port_of(port);
> +
> +	/*
> +	 * The host of CXL root port and the first level of ports is
> +	 * the platform firmware device, the host of all other ports
> +	 * is their parent port.
> +	 */
> +	if (!parent)
> +		return port->uport_dev;
> This helper looks good and this case is theoretically correct, but I
> assume that find_or_add_dport() never hits this case, right?
>
> How about move the introduction of this helper to its own lead-in patch
> and use it to replace the open coded version of this pattern in
> unregister_port(), __devm_cxl_add_dport(), and endpoint_host().

BTW, after taking a look into __devm_cxl_add_dport(), this helper is not 
suitable for this case,

the host in __devm_cxl_add_dport() means the new dport's host, it is the 
device of the cxl port which

the cxl port belongs(or the uport_dev of the cxl port if the port is cxl 
root).

So I will update unregister_port() and endpoint_host(), and check if 
there are other

places needed to be cleanup.


Ming

