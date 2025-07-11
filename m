Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9270154758
	for <linux-cxl@vger.kernel.org>; Fri, 11 Jul 2025 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752200496; cv=pass; b=H6/vE726TQzQLox4dMspLJhWxVXVUWXgXnftPs0BkXUjeR+ymVkd0QXu6rLqEyyKG5IfxV+dYWGXu8Qn+twiWgsfp6jAJ3f2sei2vTQNEvk1OUJyaWNEVOiwdDNV8aviAFl7de1ZbxyFwtlbw4EbsyYrC2JqCfWSU6/3NKKkAok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752200496; c=relaxed/simple;
	bh=w/7CdeFBthSwepATF6Nzilizh2VJm7Ju5tINa+2QX7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dN6MIlyh8UGNHfkrz7lscAkQcSPkHC45Y6+ppZQROEdjKPMJ2dVSnjZuzZnxglqcjHJz/zuxOSFfxASzHCFvLIxPEGpvDP7FKKfW8e/y/Lmx557mSOJT8881Ra4egDIi1yqSpovMo9vsNco51c1WjCuc5TBJBEtfU1KMQ7240zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=BK45WUyg; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="BK45WUyg"
ARC-Seal: i=1; a=rsa-sha256; t=1752200480; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Gqv4QGKJPVi7VmT7pLTMUH+Rkgtk3N22LJF52Se6jJFc750KRQuEhjTryzdgUMvPVHQWLbOpPi92MJRod34SIdur4OymVSvas5haP3N79YcrrcbP1WCI+/wK2vO8B/Y96yKGdxN4ciiBevnrF48IyB7RsvxEE+tk+P1LSOsNH94=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752200480; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=miCVKiKbnrGt4fGiO94uHl+UVv48orC+zPood/nDVBY=; 
	b=AbHLSohIOnD9JWA1iJn6qUFBwIV+fos0ah0IeZ8I+qpdM82MvMgSgjcXiO0Bbk6BdiHIOjrW1E8pS+Zdnd0uSLO5+tDNnfi8baoiHHICQya2Ro6r6u8vz9tXeA++4TpT4OdYMwzZAJHE4t402MHR0MSbuL2hzUCQZeP3IXGjgP0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752200480;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=miCVKiKbnrGt4fGiO94uHl+UVv48orC+zPood/nDVBY=;
	b=BK45WUygod7I/WNgXIg9uxuovp1Ze9q+rYVVKs04A3zU/+C3tm5hCjpz2pvyQwrL
	sJ9IEckziA5cpgcPpucvHRO3Uu8VZ/imd7l1EsPFTneceW6uswP40yWrAvbCx7+demd
	/CIQfB55gNkMsqc+mvmvKujiRsw8EqSTdVq4fVtA=
Received: by mx.zohomail.com with SMTPS id 1752200478828226.96147613000971;
	Thu, 10 Jul 2025 19:21:18 -0700 (PDT)
Message-ID: <f048c506-fe1b-4a26-9d0b-389cfe2e5fa6@zohomail.com>
Date: Fri, 11 Jul 2025 10:21:14 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/10] cxl: Add helper to reap dport
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20250709203619.2607133-1-dave.jiang@intel.com>
 <20250709203619.2607133-4-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250709203619.2607133-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227c49a59f04385b4301f8702b7000090c649a2ead611be2ccd63c7e2112bbc55850353b50047053a:zu080112271f4658bbbad34f9fdedc73400000718afe005e7aef074c669d06698ab5255f98c6a159117bd248:rf0801122d9eca8e5bb8ac966249756ec10000ed0a29e550da0a1552de68992f5173ff784e6c9b60206805709e2eac28758a:ZohoMail
X-ZohoMailClient: External

On 7/10/2025 4:36 AM, Dave Jiang wrote:
> Refactor the code in reap_dports() out to provide a helper function that
> reaps a single dport. This will be used later in the cleanup path for
> allocating a dport.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/port.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index a49491c14d19..9691da831224 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1447,6 +1447,13 @@ static void delete_switch_port(struct cxl_port *port)
>  	devm_release_action(port->dev.parent, unregister_port, port);
>  }
>  
> +static void reap_dport(struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	devm_release_action(&port->dev, cxl_dport_unlink, dport);
> +	devm_release_action(&port->dev, cxl_dport_remove, dport);
> +	devm_kfree(&port->dev, dport);
> +}
> +
>  static void reap_dports(struct cxl_port *port)
>  {
>  	struct cxl_dport *dport;
> @@ -1454,11 +1461,8 @@ static void reap_dports(struct cxl_port *port)
>  
>  	device_lock_assert(&port->dev);
>  
> -	xa_for_each(&port->dports, index, dport) {
> -		devm_release_action(&port->dev, cxl_dport_unlink, dport);
> -		devm_release_action(&port->dev, cxl_dport_remove, dport);
> -		devm_kfree(&port->dev, dport);
> -	}
> +	xa_for_each(&port->dports, index, dport)
> +		reap_dport(port, dport);
>  }
>  
>  struct detach_ctx {


