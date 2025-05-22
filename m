Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920E17BB6
	for <linux-cxl@vger.kernel.org>; Thu, 22 May 2025 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907020; cv=pass; b=Tuf06x6qEpNmccOpFH+igA2UQ1fT8yF3s/H2JCz9cdzDhnPOUtRGev8324YaOLSX84Y6Xjec1Azq6PJB/mgVtn4QOaELeARVTJ8fFVdxlDOEHR5ntuvkrlF7p4rEinB7C4BvQESTMRMePUPhbipTRmwJqGjPlhTNM3zPntqdO+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907020; c=relaxed/simple;
	bh=2p0aYNxmUF1Q0wzUwPLSkFV2qxfc0z43GgwB0FvNsNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9U4U9oZvNvje3yKTuv4Ffj7Y8y2uWR/FjmLaWN4sbM323KFj8h7iAua0I7UwkefvX2R3pbWlOaGiPqWevP634TGXnlx/J9BZgiQU6kRfevpYFDcJ76Tm9ZYnYXCqxm45ih3V1m134OlCfAybuIIctpT0uJjCKuxEEsmZcJY2yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=F3CJ/ETf; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="F3CJ/ETf"
ARC-Seal: i=1; a=rsa-sha256; t=1747906998; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CH93EDSa2dw7FaeLWjKOCCguGeeQTcZBXeeFPzY0nUJuLMi4hSAhOgwTPPb3A1BQQ0qyRrHLpVAkxTRBrgU7LaWMxKL6lJxnSWD2AjTHiScgEZxMRouikt9j+nxg9K0fFwIe3yhXxuxB9+1xpaVwA7CmsomM4IK4zbZoXKrOLAY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747906998; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2p0aYNxmUF1Q0wzUwPLSkFV2qxfc0z43GgwB0FvNsNY=; 
	b=j9hHfz+pysl0j4DhGZH+yUEE9PJtMAlh6sY9ahJQeb6tV2hUCUa/N12z5C4Ykop4R6Xexc4fZh24VzL1EE/nLVmMQCwWXjQbafDHWmW9GZfSOSXSBm/9VXvWEwWle9VlRJ+vcG2JkzNWjifGrepIIHUxya2rp6PfBa+MKiKcvwM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747906998;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=2p0aYNxmUF1Q0wzUwPLSkFV2qxfc0z43GgwB0FvNsNY=;
	b=F3CJ/ETfVoWwXOp3rIXqSsPYjB9UqZ3v4yc0TC2ULqebSDzoaAOTS9beW1uxslu1
	ngQ/n7BZQJe7Ht0hxHBnnXrtD19RALdM9KyNcxv3WF/JCdeiIaN5/qW29mRmghZ59+B
	ouVfA7N55qV9KANNN4uwSH2FoiFC9wWt1zDeGJ5w=
Received: by mx.zohomail.com with SMTPS id 174790699706839.831648940031755;
	Thu, 22 May 2025 02:43:17 -0700 (PDT)
Message-ID: <a8b65bda-211a-47c1-97ac-db0e9b62c039@zohomail.com>
Date: Thu, 22 May 2025 17:43:14 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] cxl: Separate out CXL dport->id vs actual dport
 hardware id
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, Gregory Price <gourry@gourry.net>,
 Alejandro Lucero <alucerop@amd.com>, linux-cxl@vger.kernel.org
References: <20250521183443.3828320-1-dave.jiang@intel.com>
 <20250521183443.3828320-4-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250521183443.3828320-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112277222aed6029acc5897193974000099010a44c985cbef18c8a180e257a8f3e5ae57d2331ebe7477:zu08011227c8d197ee5f6fb854dc3c61c3000074b5da1ffa86bfc6328f4a17207ad41d871d97e02974c27647:rf0801122d23784f6d6c4433e4fb3723580000f5401fab6d1413e05e772c3d4f0727a0b231c196b7ad2af04f583f57290ae2:ZohoMail
X-ZohoMailClient: External

On 5/22/2025 2:34 AM, Dave Jiang wrote:
> In preparation to allow dport to be allocated without being active, make
> dport->id to be Linux id that enumerates the dport objects per port.
> Keep the hardware id under dport->port_num to maintain compatibility.
>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

