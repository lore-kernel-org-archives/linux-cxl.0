Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C851D0F46
	for <linux-cxl@vger.kernel.org>; Thu, 24 Oct 2024 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772248; cv=none; b=Icx8C5Vnk5U2r3RhtI/vqbYTsAitIfcQDtTQ085RoOai5o41Hn95VD85N8p3fMYp9zxyVifsNSyopzGeh5b6WjklZnQIQePd8pzGBjkkz5Jgodl3jf036QDE3Y46r/v0x6sHr7l4VLQ3hKzve3f+b1RXQFiGwYK99nhXoSu4q8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772248; c=relaxed/simple;
	bh=2ewBk6AVxD5lOMitZANuYEonOE+decybHOYrhA2+Pdg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqSUh93tRQyfXD8QHA+2u07YfiMwkWNw3pGPVJRcoi1CZZejzLtN0CObW925ypQp3evJ1po8lES4QrEIzi6jj3PODAGZfZeeso5Jqj8TM3uUcWL5DKADi+HDAbkeuP9uQxpqawAVeoBV/d4fL8mebOADbZSnATXGvN3Ks/7jH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZ4df3VNJz6K9FJ;
	Thu, 24 Oct 2024 20:16:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 46F6A140B2F;
	Thu, 24 Oct 2024 20:17:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Oct
 2024 14:17:22 +0200
Date: Thu, 24 Oct 2024 13:17:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] cxl/test: Improve init-order fidelity relative
 to real-world systems
Message-ID: <20241024131721.00000a58@Huawei.com>
In-Reply-To: <172964784521.81806.15791069994065969243.stgit@dwillia2-xfh.jf.intel.com>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
	<172964784521.81806.15791069994065969243.stgit@dwillia2-xfh.jf.intel.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 22 Oct 2024 18:44:06 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The investigation of an initialization failure [1] highlighted that
> cxl_test does not reflect the init-order of real world systems. The
> expected order is root/bus first then async probing of the memory
> devices.
> 
> Fix up cxl_test to reflect that order. While it did not reproduce the
> initial bug report (since that is dependent on built-in vs modular
> builds), it did reveal a separate latent bug in the subsystem's decoder
> shutdown flow. Fix for that sent separately.
> 
> Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
I'm never particularly confident reviewing cxl_test but this looks fine to
me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
