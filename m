Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2CBEEAA
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950034; cv=pass; b=h4KgR9DeWUORE30cPyZEEqsCGKrSXCAlOI2oHbT2JLd3CNkGvMCQgZjifWuMb/G29y/MLCZ/qtgEvOAQ1lNnLxtkZmg3WWaMsdcOd93v/KhQRPG2HECPybaHGa9ZGglyk/SVwMNqbNLuxZeinn4j/AaZJZ9aOHa3Ap63bvITeVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950034; c=relaxed/simple;
	bh=jERpTZTD7SskJshjkAJZh9odqh6qpidl8IGYog0cEzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZVJ3yPEbjygaVjoirZ6JoHL5JO0g4zxX5wDmTeyXnxrWeEZQ4YRxfX/uwJrcWSJjLu815te7/lcOGlP/hen8Csa/Rolz/wLR76b6I7y5ynaPMA9Brx9LZznzAuQbzLfQtrYgfhBAtnqiwGABFoSqtJQSrFhtrdHRf4szFcGtXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=fffOzhas; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="fffOzhas"
ARC-Seal: i=1; a=rsa-sha256; t=1739950018; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y2GGh+alorCgQooxk9BPG2o69o0WcxJNyGjMBvcEblLYAitothrREkkmGGP/JWOLZPIF5D2aseUpWbbWyvAsZykl8kVZN4P5Jc6ilZHVJt4Iopg5Xd+wpI6PrbDoQxaqiB2FKjvixWI6kI3xefR1dy1UDPnh3xk1LrKJqtO4VOA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739950018; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jERpTZTD7SskJshjkAJZh9odqh6qpidl8IGYog0cEzI=; 
	b=ZnWtNY31GvjrRqBNDJ4+7lRULBoZXWPk+nsQlz3lvHsnIfIriOp4a7EawIQVglHJyStFWM+2vAr3fzMVCoPTUVONMHyLoNk+tDVuHrI81c8xrtK/6SjLC21dS7rWSmncu6yaXEctLOY4auMOELFczpWQFgj4Dw/+zODHX5ShpIA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739950018;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=jERpTZTD7SskJshjkAJZh9odqh6qpidl8IGYog0cEzI=;
	b=fffOzhast0ZfNom9H2VXcb/p+7vz6olGFRRD6Q7NmAemmz3srSLa/Qj/N21J29Sl
	qc5JkXnpGULO+Mh0ezjMrN7mVSbA6hqN3ioAkBZnwuH5HwIdgTn9B3N3j9Xl0vJdODx
	u6tYQj4B0HA8BPLmIvQ04l0n7xIjGFJNe9TwGD68=
Received: by mx.zohomail.com with SMTPS id 1739950014873231.41030088754474;
	Tue, 18 Feb 2025 23:26:54 -0800 (PST)
Message-ID: <16a2d669-45e0-4ddc-ab1e-45698d1512d4@zohomail.com>
Date: Wed, 19 Feb 2025 15:26:51 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/14] cxl: Move cxl feature command structs to user
 header
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com, saeed@kernel.org,
 linux-cxl@vger.kernel.org
References: <20250218225721.2682235-1-dave.jiang@intel.com>
 <20250218225721.2682235-9-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250218225721.2682235-9-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227350d42bb8ee89856a51602be00007b5fe014fad684812f09f3b604657cd0f6f756a318f89b98f1:zu080112271b724d5ed48638b2762d29b5000047bbe946f6e5244e7da9db5e17acd5fd89a44ef3414b9f218e:rf0801122d52ae8da5f2d5d5348ad12b3000001ded22d4949de868081cab5409f65a89e8bebf456320a0628fd5d614aec5e8:ZohoMail
X-ZohoMailClient: External

On 2/19/2025 6:54 AM, Dave Jiang wrote:
> In preparation for cxl fwctl enabling, move data structures related to
> cxl feature commands to a user header file.
>
> Reviewed-by; Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
