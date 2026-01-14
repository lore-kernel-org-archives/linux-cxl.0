Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F863009F6;
	Wed, 14 Jan 2026 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411680; cv=none; b=cwuQdMmWt8eiSU2NhlOKYp8wBkBQ37Dade6XOW3sTSFBRIabKu9x2ls2Tnk6+SjkVSmBjArQx8W0Mioc4g2kcMYzFV6DF2egbYCwKlkl78biueahsRpfKmO8qY/A6w4twmYwSOgHR7lc7FLOpjk3J/OPQhavLi/qYq3ta9zc5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411680; c=relaxed/simple;
	bh=m+SYEh/IiGmnEgrdEv27uXtqymbTpeuiTu/N6f3F940=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4R12N1fv3A7iUGJt/u1ahBXq5ikOgIJkBeBHjfWOnNKtNanZNyKeZVx4i1qTvfbkzoIeJskrxZWeRaitQK4LL9fwnIHb9jqydAS5G6fwOhsbXGpuvcUCCBgFSKjp2nQQLwpFb1UZmgLCDRjDI2+pNNODKutzrEEB1dkeBz+er0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drtNX314NzJ46CZ;
	Thu, 15 Jan 2026 01:27:40 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 61C9940572;
	Thu, 15 Jan 2026 01:27:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 17:27:54 +0000
Date: Wed, 14 Jan 2026 17:27:53 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] cxl, doc: Remove isonum.txt inclusion
Message-ID: <20260114172753.00003f71@huawei.com>
In-Reply-To: <20260112111707.794526-1-rrichter@amd.com>
References: <20260112111707.794526-1-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 12 Jan 2026 12:16:43 +0100
Robert Richter <rrichter@amd.com> wrote:

> This patch removes the line to include:: <isonum.txt>. From Jon:
>=20
> "This include has been cargo-culted around the docs...the only real
> use of it is to write |copy| rather than =A9, but these docs don't even
> do that. It can be taken out."
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
