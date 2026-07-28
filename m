Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DDC2D7DDB
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 06:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221032; cv=none; b=QQxZFxMPGKSugshBqFF9+ZWDpMWTRxGW/+4chjaZJyMd6BV1ZgJ/UFhL+LHDstmthdvDoZ2fMujp822CezSuUmD607v0PimsI8/NUu9+iofwQCnOans2Sn4u73WLBz8mD4FF0P9RPb0EYGwScXWYji4hUaLut+Kxh85CTpTQ+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221032; c=relaxed/simple;
	bh=deeRjYXm4nKLPgqT2yghDPFnhTTtqavBjUaYnUZCGls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q52H+lrT55bIENIs4SyfFk8DMeWchw4NEe9t95iS8x7jo/QxaFK6jTZ8ypk5jIUoHwXJGO1e4n6rs0EXjsFiUt5/LGkaI12SwXXQFzmsGKpO++3o35A30oIK77suSSBjsHfxNYpxXU/KddkZnV4+yaD6sOjr5aP4JF0v8OSytAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=q7uocdtw; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="q7uocdtw"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66S6he3b021283
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 28 Jul 2026 15:43:40 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=LzBvc4QFC8CxCqpPgeLUIT+5t6SXNYVeTUkmA0K0p6Y=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1785221021; v=1;
        b=q7uocdtwCcoAT/zxfuxXSZqRJynUoTZdYmTNCMBVMpw/uB6uR26FkaaTz5Hd4+DW
         Y+AC7WvK202li+NkKtv5jskowBANnNTQabrc5S1Cc9Nr3aDz0nommTdFKUs0ZxpP
         Ozd1vV0TK1XlusEyFLK8ZyFIGrnSZK1pelvWl5OB6Sb2zYEhgBEOpS8pufjfOxO5
         Ddv1pWX2F+pLGN8jd3mbNla9b7V7X1j9n0+Op8a2jXUC61w1C36mb5wMFu4vSuDc
         QJQ/+Y01cFdQeOKFgCIUfi2sKKobzj6rwMAFwqtPuY7N+g1zo/TKUJ8IGphh1Tah
         X+TdvEO7SzcuHbuddOaA/Q==
Message-ID: <7540f97d-8538-47cc-b075-48b4ff4d8d56@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 28 Jul 2026 15:43:39 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] hw/i3c: fix default return value of
 d2_i3c_send()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
        Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
        Jonathan Cameron <jic23@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
        Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
        Phil Dennis-Jordan
 <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
        linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-6-d0c4831ed7ea@redhat.com>
 <0206544e-1d58-4040-9cd1-f36c917d88cc@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <0206544e-1d58-4040-9cd1-f36c917d88cc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/07/27 16:40, Philippe Mathieu-Daudé wrote:
> On 26/7/26 22:44, Marc-AndrÃ© Lureau wrote:
>> Fixes: 208772a189f9 ("hw/i3c/dw-i3c: Add data TX and RX")
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   hw/i3c/dw-i3c.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
>> index 6386499dd9fc..7b887fbd60cb 100644
>> --- a/hw/i3c/dw-i3c.c
>> +++ b/hw/i3c/dw-i3c.c
>> @@ -430,7 +430,7 @@ static int dw_i3c_send_start(DWI3C *s, uint8_t 
>> addr, bool is_recv, bool is_i2c)
>>   static int dw_i3c_send(DWI3C *s, const uint8_t *data, uint32_t 
>> num_to_send,
>>                          uint32_t *num_sent, bool is_i2c)
>>   {
>> -    int ret;
>> +    int ret = 0;
> 
> So IIUC the issue is being called with num_to_send=0.
> Can that happen? Apparently no. Could we assert it is
> non-zero?

I kind of prefer to apply the same logic I suggested for walk_gpt():
https://lore.kernel.org/qemu-devel/d9c4321c-ed39-4da6-926b-bae4b1491a52@rsg.ci.i.u-tokyo.ac.jp/

i.e., if num_to_send == 0, there is no work to do, so the default value 
should tell that no error happened. ret = 0 does that.

Regards,
Akihiko Odaki
