Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12730125B2;
	Mon, 15 Dec 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765805149; cv=none; b=YIOXSn1pRErUgi3a7LTKY53+ovQFPK5CkvQomaOKAtI+jObIvOH0EYf3TJ/lQUy3oMMPe6QYHgSzOQGbQ0kuDTICbSuQhBIC9gZhzaZ8BL3azp6zH4iaamzDe4preE3f55V2puWi2jk91Jh64l8Jhd767Tl6UDGoyOqi64oyuPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765805149; c=relaxed/simple;
	bh=A8jNHdfyLvaI2vy/A+mJQLG3AThIXBQm+8U6ndX2rYQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFbsPhZq/WPSpntVxXV/kS0qRmImcpGPmra3Yj5+2+m4J2gWpqeajwndFT7YB6krbbMjAO6NJBjCYIRYLmpSF/GdJ3LRvTpQEm19BtKKHEgpq8jSlhmGHlu595rU5yj9K95wtsy0QJ+NFxYPsyEwPUuhlmhdyQxmytfHSy3p/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVLQh6fG8zJ46c1;
	Mon, 15 Dec 2025 21:25:16 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1507940539;
	Mon, 15 Dec 2025 21:25:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 15 Dec
 2025 13:25:41 +0000
Date: Mon, 15 Dec 2025 13:25:40 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v8 13/13] cxl: Disable HPA/SPA translation handlers for
 Normalized addressing
Message-ID: <20251215132540.00000f1b@huawei.com>
In-Reply-To: <20251209180659.208842-14-rrichter@amd.com>
References: <20251209180659.208842-1-rrichter@amd.com>
	<20251209180659.208842-14-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 9 Dec 2025 19:06:49 +0100
Robert Richter <rrichter@amd.com> wrote:

> The root decoder implements callbacks hpa_to_spa and spa_to_hpa to
> perform Host Physical Address (HPA) and System Physical Address
> translations respectively. The callbacks are needed in cases where HPA
> != SPA to convert addresses for tracing and error handling and to
> setup Poison injection. Currently this is used for XOR interleaving.
> 
> In AMD Zen5 systems with Normalized addressing, the addresses of
> endpoints are not SPA and those callbacks need to be implemented.
> 
> Now, as ACPI PRM translation could be expensive in tracing or error
> handling code paths, do not yet enable this direction of translation
> (hpa_to_spa) to avoid its intensive use. Instead, mark the HPA invalid
> and return an error for this case.
> 
> The spa_to_hpa callback will be used in region_offset_to_dpa_result()
> to determine the endpoint by the position in the interleaving
> chunk. With Normalized addressing, the order of endpoints in the
> interleaving chunk is implementation defined. Do not use this approach
> and and return an error instead.
> 
> Disable both HPA/SPA translation handlers for Normalized addressing by
> returning an error (ULLONG_MAX).
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

I'll be interested to see whether we end up deciding in the long run
that paying the cost of the call is worth while to get more useful
error records.  This makes sense for now.

Jonathan
