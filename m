Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F418023C8A0;
	Thu,  8 Jan 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888836; cv=none; b=DSjFCA5bH46prtNOoh/W1kzrJMIBebifctVmrs3GnG5k848PGuZL7hewhapCMe53rbeThdiCqJVIyUlkowxwh2ZsVze/tX5m429x2wYcRApQOvaL/G1erNkyuEMAXbW4Hbsqg4i0rfVBlJ5mMh767bV4OBcpXZPYWBUGXHdf+DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888836; c=relaxed/simple;
	bh=eAruJ824F6snCDLSJZNbyWBJwEPfJYrWI2wGBV4DYkc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2SxlPcKabxJ1H76bTX+X3XUcdvxbFWArFbB1KQmKhP97m3FPHBYBv4u0llIq0CKfohIT0FOdVROBi71f+xDdrCP1ynNh4ZFmpZbeCiVI4ZfvgfRS5bTK+qsX/JUwwJghaSPWe64cukJ6rmlqj2S97iwwNEKAOo4sAgkHwHO1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn91y5f5FzHnGdy;
	Fri,  9 Jan 2026 00:13:42 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 340124056A;
	Fri,  9 Jan 2026 00:13:51 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 16:13:50 +0000
Date: Thu, 8 Jan 2026 16:13:48 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cxl: Check for invalid addresses returned from
 translation functions on errors
Message-ID: <20260108161348.00003911@huawei.com>
In-Reply-To: <20260107120544.410993-1-rrichter@amd.com>
References: <20260107120544.410993-1-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 7 Jan 2026 13:05:43 +0100
Robert Richter <rrichter@amd.com> wrote:

> Translation functions may return an invalid address in case of errors.
> If the address is not checked the further use of the invalid value
> will cause an address corruption.
> 
> Consistently check for a valid address returned by translation
> functions. Use RESOURCE_SIZE_MAX to indicate an invalid address for
> type resource_size_t. Depending on the type either RESOURCE_SIZE_MAX
> or ULLONG_MAX is used to indicate an address error.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Nice patch.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
