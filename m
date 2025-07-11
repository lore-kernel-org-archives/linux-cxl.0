Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C5BA33
	for <linux-cxl@vger.kernel.org>; Fri, 11 Jul 2025 02:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752200653; cv=pass; b=AZOF6A/PyHSFwyJtXUnoFe+gda9Vg/UqMXPsGypAMiDL7iR1Xrvqsnf9LlPsSIrnZcm6xWyKjAs0TOVe8Bhkiobp7MJuTAn25T6h6eu2B9Ripqo2uG2085WVvb8W+n9M+lZCriwohuX70+Vbz+qVxqG9kL56KKUpPiOC/QV/h/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752200653; c=relaxed/simple;
	bh=36CRTC+wFwOxwB58oleQHu98qNZvNtYaGbMomeiSamM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6M090+j5+bmxIczFv4UrUIzwQDBA4X8Y4BFQ8kq4zP0w55kaDL2lvBMv3+uC0LxOHK99uDaE9g88C/uSRxbN4qbf2Oi8d9qhWYXi73YxMzoDraEL8Yvrpy08mX1s4YBnpqGOPlDGNDhSlj0lO85bKrqtiu0i02Lkl7oWw+hCiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=EHXru0T4; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="EHXru0T4"
ARC-Seal: i=1; a=rsa-sha256; t=1752200640; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NWcO5zrkn+UVnW7fESfu8Bbe+lnkhXM7/QnMlJgip2nftGg5bl40d5R2biMqYhs47i9xNtK0EpOvwWpIs/GnCCmWhM7Y3V5SJg2VeFmPc8ukbOiSYotDLHTA0I0UIja3K1ocqE0xKZfeMNZurxwDEAkA38Lj7HLQJpiQleqv62c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752200640; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=36CRTC+wFwOxwB58oleQHu98qNZvNtYaGbMomeiSamM=; 
	b=E80F2U6IYrQ59tqbHt8t7qH0qqAqxwmDCvYA4oqOi2ug2vMv9UaWIIAl8F44EAhdHExNlHPXpIIw7Kdnbm9OgkDlQRS5kM7yXqfqGkj/bAFWw+8XtMWL6N3qMgsCfS2jjBEVu99zUdkVr4ZQCcBrnNiMiJmsgTkML3hcibfd0mg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752200639;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=36CRTC+wFwOxwB58oleQHu98qNZvNtYaGbMomeiSamM=;
	b=EHXru0T4Wtof22Fbtr8OBnzRgUz9Ri4XENmnyygDZ6tjX93AVb8cuYznl+t1EmbK
	Rtv/Mlz3Yyo7WmKpHSb/khKpHoTq2NCNeBDswf+48NUk7mdB3YW0VSl52GtGGLkYi01
	m0Ah6CR7IN4CD0IMFKTQPPaFBj+j6b8psJ/V4lmo=
Received: by mx.zohomail.com with SMTPS id 1752200637275625.6390412151468;
	Thu, 10 Jul 2025 19:23:57 -0700 (PDT)
Message-ID: <dd947d4b-bbf7-4468-a7a3-67ef14ab2c41@zohomail.com>
Date: Fri, 11 Jul 2025 10:23:52 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] cxl/test: Add mock version of
 devm_cxl_add_dport_by_dev()
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20250709203619.2607133-1-dave.jiang@intel.com>
 <20250709203619.2607133-7-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250709203619.2607133-7-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227b39954a8667798b31d7a7ca20000ffe35a46fd1510c2bba8fdc4f304ff1408f45e799c13a3c311:zu08011227de0bbda055943db699a9960300000e8048d5db8c5796c5d6af28c48bd5084f5e5f08e736bc480f:rf0801122d89399f6bcb38ab517459177300002a44632b2f2cf315530d7525075fe560a06379fbb68bf2b566677ddc232362:ZohoMail
X-ZohoMailClient: External

On 7/10/2025 4:36 AM, Dave Jiang wrote:
> devm_cxl_add_dport_by_dev() outside of cxl_test is done through PCI
> hierarchy. However with cxl_test, it needs to be done through the
> platform device hierarchy. Add the mock function for
> devm_cxl_add_dport_by_dev().
>
> When cxl_core calls a cxl_core exported function and that function is
> mocked by cxl_test, the call chain causes a circular dependency issue. Dan
> provided a workaround to avoid this issue. Apply the method to changes from
> the late dport allocation changes in order to enable cxl-test.
>
> In cxl_core they are defined with "__" added in front of the function. A
> macro is used to define the original function names for when non-test
> version of the kernel is built. A bit of macros and typedefs are used to
> allow mocking of those functions in cxl_test.
>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
[snip]
