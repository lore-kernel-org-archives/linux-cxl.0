Received: from isrv.corpit.ru (isrv.corpit.ru [86.62.121.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28ED2E3F7
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jul 2024 05:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=86.62.121.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721797411; cv=none; b=nfTYAF8HlJgVJGCXfjvQwFDG1TB9HoiCMbsCuk5Wy0ESkEDcACi2cJtyM4ciN76BghNgX5P+dZwzPDGkTyAtdAY9GY8MeZLYb5lGWEOf7Pu7F/OUT/ov2SXrD+IjYR1GjrmubPWLmbbHt7N1tD7VnS4inGURovEsOpNYLu7dZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721797411; c=relaxed/simple;
	bh=0tohlDqQRJoTZYht+Nqh+JDz3NbCAQwEDhTXw0lfeUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glVmlV2VMOVhsuxZYRod0ZNiwDh3wIaifv849DTILO9Lax0DTE/UQh+zjpsnjI8Cg/BM8N5X0zQs8anFnHV/+LDqj+TlEivmBY8lcV4zg0/dJipX2lWv2w/oUKyEl01apkK2IKa+UWKETvK+qG1MP2mKGrciUNO+ATCY9MFEf1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru; spf=pass smtp.mailfrom=tls.msk.ru; arc=none smtp.client-ip=86.62.121.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tls.msk.ru
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id 36D887D275;
	Wed, 24 Jul 2024 07:53:38 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
	by tsrv.corpit.ru (Postfix) with ESMTP id 0BA291121FD;
	Wed, 24 Jul 2024 07:53:49 +0300 (MSK)
Message-ID: <1c89931e-d800-452b-8dbd-5c433149f723@tls.msk.ru>
Date: Wed, 24 Jul 2024 07:53:48 +0300
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/cxl/cxl-host: Fix segmentation fault when
 getting cxl-fmw property
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, mst@redhat.com,
 qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, linuxarm@huawei.com,
 Zhao Liu <zhao1.liu@linux.intel.com>, Xingtao Yao <yaoxt.fnst@fujitsu.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20240705113956.941732-1-Jonathan.Cameron@huawei.com>
 <20240705113956.941732-2-Jonathan.Cameron@huawei.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <20240705113956.941732-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

05.07.2024 14:39, Jonathan Cameron via wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> QEMU crashes (Segmentation fault) when getting cxl-fmw property via
> qmp:
> 
> (QEMU) qom-get path=machine property=cxl-fmw
> 
> This issue is caused by accessing wrong callback (opaque) type in
> machine_get_cfmw().
> 
> cxl_machine_init() sets the callback as `CXLState *` type but
> machine_get_cfmw() treats the callback as
> `CXLFixedMemoryWindowOptionsList **`.
> 
> Fix this error by casting opaque to `CXLState *` type in
> machine_get_cfmw().
> 
> Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup a machine parameter.")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
> Link: https://lore.kernel.org/r/20240704093404.1848132-1-zhao1.liu@linux.intel.com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Is this a stable@ material?

Thanks,

/mjt

