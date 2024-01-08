Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ACD487A1
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7ts34bGvz6K9Tg;
	Mon,  8 Jan 2024 20:38:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F0321140C98;
	Mon,  8 Jan 2024 20:41:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 12:41:04 +0000
Date: Mon, 8 Jan 2024 12:41:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Dan J Williams <dan.j.williams@intel.com>, Adam Manzanares
	<a.manzanares@samsung.com>, <vhache@rambus.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC] Do we need dedicated LSF/MM/BPF 2024 session for CXL
 memory?
Message-ID: <20240108124103.00004afd@Huawei.com>
In-Reply-To: <42978BEA-D194-41F4-A619-BAF02CE8F4FF@dubeyko.com>
References: <42978BEA-D194-41F4-A619-BAF02CE8F4FF@dubeyko.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 22 Dec 2023 18:10:21 +0300
Viacheslav Dubeyko <slava@dubeyko.com> wrote:


> 
> Hi Jonathan,
> 
> I think QEMU is important area of CXL memory emulation and testing.
> So, I assume we could have interesting topics and discussions here.
> Any suggestions for this? What do you think?

Currently I'm not seeing anything that would really suit LSF-MM.
There's lots going on it just won't much benefit from the people I'd
expect to talk to in that venue (about QEMU emulation side of things
anyway - even the virtualization topics are going to be too early stage
to really discuss much this year).

Also from person point of view, I'm avoiding travel until the summer.
Might participate remotely.

Jonathan

> 
> Thanks,
> Slava.
> 
> 
> 

