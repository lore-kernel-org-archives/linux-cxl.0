Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614292E06D2
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988324; cv=none; b=AwogjaYps9nFJGUu/DFta4autlSRfCsr/vdOcroagpNtIzxn5sFpLGPdFQjFr/yyqS7dmsrx+isMh/dvUu3+2jWwXjZx0bFAmXpIiHrvWMzHUhimhybOmw8WeTqNQ08/HdcEUZk03mb6YYFHsviYc/Dlk8ZfNqsTqsh3zNxtRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988324; c=relaxed/simple;
	bh=rGLN1HFrEyVDEQ3Jtkf7kWDDwJ6TlgtI4zHWSfJj38g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVvasNUYXqn1oxiP8miiGhjCKvA2grlmQcNHakMihgfhzgVdjQLiCQcoFfn78AOmxKaoNeTFCEYRTJBscBpX3i2k81mqZgREz+R4Pp8lCENwSEwWSFJAGja5G8k9V641phJDMly3VqBTkXBRTfWKEx6WPSMaY4fHWbR65Vrwd0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWf9G70L8zJ467g;
	Thu, 18 Dec 2025 00:18:10 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F77840570;
	Thu, 18 Dec 2025 00:18:40 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Dec
 2025 16:18:40 +0000
Date: Wed, 17 Dec 2025 16:18:39 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 06/17] cxl: Replace cxl_mem_find_port() with
 cxl_dev_find_port()
Message-ID: <20251217161839.00002a11@huawei.com>
In-Reply-To: <20251111214032.8188-7-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
	<20251111214032.8188-7-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 11 Nov 2025 15:40:21 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Change cxl_mem_find_port() to take a struct device * instead of a struct
> cxl_memdev * in preparation for adding cache devices to the port
> hierarchy.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Maybe we'll bikeshed the name in a future version though.
