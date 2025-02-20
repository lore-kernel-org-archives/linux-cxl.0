Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BDB1F460D
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058548; cv=none; b=gMeuxCx/QPaDEpxMPLdbdqkYCFH2zY1Cfwb62OrQmd6CNB3JenHV3nhLEqXTV5FnO1Xwq8Ay+lkXnFazlSMey9g3QD9fgRVmdLXmDU6Io8+VXVys8NcIL3nqrwxN88taO+IhMlZ521wGMtTv1JTacA+morO5a8vMiJoDYI4PdeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058548; c=relaxed/simple;
	bh=1tW7VBLl9qamleZ0juNblQcKdfcTcvTW5f+fv/2wKC0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=SDGD0SJW4u1hzu5nOC0x+5KtfQgTCHX6ZyKyBrYvZpSmOCiiwCOIyLpkMI5e5Tjh4bMxTWTanbn1USeX4BZjtKOgNSFC296NdoVxC3FaL5VsJZgujbhxvh76aqWwqtOnr8wR45Ry4o/pAsyf7OzCufv9YmYp4fHjZNVtqE5SCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8r/L8hs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8r/L8hs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740058545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p2+p1teF2pKz1azjS8ntkPhlcJXUjNb0K0WphETD1Wg=;
	b=Y8r/L8hsJWNh0uKEeiEYm9CKT7d8cRUcFBu2OGwrEtanmgIjhCcFmiWv7fSVCyeQNHnuhD
	dXmBIKd7/7rAwsr5rBCppUPSpxNiVzxgLTPklYKJKHk01l6gwnckTl5d9K5wm+liZhSi4i
	oI2x5azBEATzlAP1XnaGYiIZOiR08lU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-rhaifzDyPcWk2x7tD_unvg-1; Thu,
 20 Feb 2025 08:35:44 -0500
X-MC-Unique: rhaifzDyPcWk2x7tD_unvg-1
X-Mimecast-MFC-AGG-ID: rhaifzDyPcWk2x7tD_unvg_1740058543
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AC82180056F;
	Thu, 20 Feb 2025 13:35:43 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.65.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD08B180035F;
	Thu, 20 Feb 2025 13:35:41 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Donet Tom <donettom@linux.vnet.ibm.com>
Cc: Alison Schofield <alison.schofield@intel.com>,  nvdimm@lists.linux.dev,
  linux-cxl@vger.kernel.org,  Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH] [ndctl PATCH v2] ndctl/list: display region caps for
 any of BTT, PFN, DAX
References: <20250220062029.9789-1-donettom@linux.vnet.ibm.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 20 Feb 2025 08:35:39 -0500
In-Reply-To: <20250220062029.9789-1-donettom@linux.vnet.ibm.com> (Donet Tom's
	message of "Thu, 20 Feb 2025 00:20:29 -0600")
Message-ID: <x49y0y0oi1g.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n5Dy4koi1G_NVjuDc3vH2SNQoodmoOPs1HmSP6-Q7gU_1740058543
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

> diff --git a/ndctl/json.c b/ndctl/json.c
> index 23bad7f..7646882 100644
> --- a/ndctl/json.c
> +++ b/ndctl/json.c
> @@ -381,7 +381,7 @@ struct json_object *util_region_capabilities_to_json(struct ndctl_region *region
>  	struct ndctl_pfn *pfn = ndctl_region_get_pfn_seed(region);
>  	struct ndctl_dax *dax = ndctl_region_get_dax_seed(region);
>  
> -	if (!btt || !pfn || !dax)
> +	if (!btt && !pfn && !dax)
>  		return NULL;
>  
>  	jcaps = json_object_new_array();

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

