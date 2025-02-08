Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E5215098A
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738995594; cv=pass; b=DnTGuS/eO7aZe5Z/I7Bw+yVdYYWvweNeH3ekPniXGP6kqBQkTU1I0PXvzr2CtqjFw1BIE9ViwTqhBqVvyNEyrkvR2guUr3iii2d+qwxhrBv0exyEYKuED6fOEklAqlGIs68adwMZyVEiJfchQ/JQ6OMQ7huf3d8ZbvE3Fy0BrMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738995594; c=relaxed/simple;
	bh=RUiXEQ+XJkgW/oV+epIdN6S3ExW46MCYY4k3Hv5qkZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CM8vn75pFRFZUUUfa10rNyz08bOy8GXF/BwOrr/d8nYlxjgP9SDkIMHpysAMfQm3l7P+Rg501mGnHjmhv+Th9wKlPtFInmsmQHMZDXm/esHfVCShR7BUwQ2NtXt5X2Pfb28gkJPRvOjUvF8Ps/YjJVWiIbsC2YpNIeNgbOnaeFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=G5hwqUm1; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="G5hwqUm1"
ARC-Seal: i=1; a=rsa-sha256; t=1738995455; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hbBJ3PrWSqStmck3PK75RFGFA1SBMPv2zzv4MOJGA6s+2v3Lvuvc098+RxOXXXg7HK5UAHNwCmh/OU6BTo/5uvDrY2saiNG++VdKk9E6eivgQO45Ykx1ixXP9HSjeynP819qs/+vbeigbRUot80XxTHlDKVYs/5y6dUjTH8DigY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738995455; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RUiXEQ+XJkgW/oV+epIdN6S3ExW46MCYY4k3Hv5qkZU=; 
	b=LFlEJdFo4H+rInCLGHws0ylR9qLd4B9+WF9Vvi5WSUr2PQvR9m3AcW6W/pi7zhKMQFz9ansnyIPdAVwmbTqOLUGvoH/we05FU9gEdNMcAvNE0TU7yqTk+yjyB/dVkJmbXPp40pkTIFlqGQWuXo8GFb9Pqy3HmJ1FbVRhGnpRtW0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738995455;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=RUiXEQ+XJkgW/oV+epIdN6S3ExW46MCYY4k3Hv5qkZU=;
	b=G5hwqUm1ue+xtWFLBafOygy6QlxjnrW4KDb8pULrbmqp6FWossM8fLkIkThmvW0C
	fP29+Lv1xODrFhhUPepLLimpYOx0aieaIJ3v61LnqZ0kbaBk0eT4lnm6dqPSBxQYIXu
	ny6T7KT+AIFoDk53mMFV/S3XyhfS70kgYTi8uVhM=
Received: by mx.zohomail.com with SMTPS id 1738995451976490.6310014359191;
	Fri, 7 Feb 2025 22:17:31 -0800 (PST)
Message-ID: <ba78f418-c50c-4074-bcac-11dfc28247ce@zohomail.com>
Date: Sat, 8 Feb 2025 14:17:30 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/15] cxl/mbox: Add SET_FEATURE mailbox command
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-6-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250207233914.2375110-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227da5bf2416208e9de2334f1ae00001bd3030419ad407ea23343406cf2533972b2af8411d08564d3:zu08011227178c428caea54d4a7894166c000069fc466fc6a58756d501d8931d55eb7bd5ce2a734fa59064c5:rf0801122d1c127a7f6a035b7f270104640000bfeb6b526cec6644f9485fb410a3d490413a578ddb6857c6f483adb98a4fa3:ZohoMail
X-ZohoMailClient: External

On 2/8/2025 7:37 AM, Dave Jiang wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
>
> Add support for SET_FEATURE mailbox command.
>
> CXL spec r3.2 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> The settings of a feature can be optionally modified using Set Feature
> command.
> CXL spec r3.2 section 8.2.9.6.3 describes Set Feature command.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
