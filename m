Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07139269AF9;
	Wed, 23 Apr 2025 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441369; cv=none; b=UlnyWAWayJqCWmFTNK1jXKFOb1mSKtXbOvD5g/R8IL4gDEoR7H7br2QXxaUlyP1zONJ5L/1yb0/Kf3UdMG4VZgyiz6muzpPG32WiCEs5CAUA0NIkLKDJp2lykMN4fqkaLG1KOTdLgbr5Gp9SPsy1M71qCkp5S++mqdclhHdUAck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441369; c=relaxed/simple;
	bh=d1k9gomSqLICNqAukAmQAOjJWV3hq4GG2jes7N+MC6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtTJmncbWx+2KI6dWJJcX84jFeeXTWVKk2VUBvl9oR1EIo1VSEKDHNZcLspsntPJxT1+ho1PeCjlc6ahfATIdgHVD3pMI2ShWS9a88/+YQYZMIo4nzUwvfSStt2fnUTTSEjg9VkIkYjHiRF0Fol5u7mUmbt6XpDBV5Eh6d2tIFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRUKawQV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRUKawQV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745441368; x=1776977368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d1k9gomSqLICNqAukAmQAOjJWV3hq4GG2jes7N+MC6E=;
  b=RRUKawQVRewPbBHjdqP/W24JDy4TCSARjsL/QmtAT2UKbkyLoa3v31IA
   nM680TRM9e+TxivJdhC08L+I+LaqStA6vzwceHgAnpg69t7IIJ1SR1tyk
   WL3BrlaYlxWLLjFSpkKPOfpX8fX5otmTMWEQ8FQnv58bUoHPbPVD9nVY0
   2kpyr/Nm9Qa5dTKQq/pB3V4sB1NafvWfPIB9JZZBeE9VBvdyuabgFjgAF
   EvCXlf7n1iTgQv5XefId/OIA1jtTOviSmwu1tShXtHoaod8nAkUK8seo8
   xbWqzDUMFEQrId1hWg0FKQ+JZVcB3YmCmjRYjgiZfmomsA4ZqVADhNoA+
   Q==;
X-CSE-ConnectionGUID: GsL+Iz32TkKhhV7BGe0wsA==
X-CSE-MsgGUID: zTfHkPYdSia539RZIr7caQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57694274"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="57694274"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 13:49:27 -0700
X-CSE-ConnectionGUID: vrIxLQdeQ0a956p9P0Dd6g==
X-CSE-MsgGUID: ffoZS7vqRqWWBNtQ0JACBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137501881"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.208])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 13:49:24 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>, Terry Bowman <terry.bowman@amd.com>,
 Robert Richter <rrichter@amd.com>
Subject:
 Re: [PATCH v4 11/14] cxl/region: Add a dev_warn() on registration failure
Date: Wed, 23 Apr 2025 22:49:20 +0200
Message-ID: <2827426.aRXLXkqSa3@fdefranc-mobl3>
In-Reply-To: <20250306164448.3354845-12-rrichter@amd.com>
References:
 <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-12-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, March 6, 2025 5:44:45=E2=80=AFPM Central European Summer Time =
Robert Richter wrote:
> Esp. in complex system configurations with multiple endpoints and
> interleaving setups it is hard to detect region setup failures as its
> registration may silently fail. Add messages to show registration
> failures.
>=20
> Example log message:
>=20
>   cxl region5: region sort successful
>   cxl region5: mem0:endpoint5 decoder5.0 add: mem0:decoder5.0 @ 0 next: n=
one nr_eps: 1 nr_targets: 1
>   cxl_port endpoint5: decoder5.0: range: 0x22350000000-0x2634fffffff iw: =
1 ig: 256
>   cxl region5: pci0000:e0:port1 decoder1.2 add: mem0:decoder5.0 @ 0 next:=
 mem0 nr_eps: 1 nr_targets: 1
>   cxl region5: pci0000:e0:port1 iw: 1 ig: 256
>   cxl region5: pci0000:e0:port1: decoder1.2 expected 0000:e0:01.2 at 0
>   cxl endpoint5: failed to attach decoder5.0 to region5: -6
>   cxl_port endpoint5: probe: 0
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>



