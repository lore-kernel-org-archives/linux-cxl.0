Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8924C171AA
	for <linux-cxl@vger.kernel.org>; Fri,  6 Sep 2024 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725582591; cv=none; b=lQqwsEPlM7uhd6GqXp1geNnxsqN+mAs6/tZ3KonNhX49I2H7QD13YgD9QSRNyXa/Nd7UxXXHiMbMJe0M1JD6gIgHWw+jyYJpjcCoJVQM1ZrpTFY5ZTOzlSPRe5sfturj8FnIgppztxCUsCe8+VvZTA7VAJ5RmUKPnesS99YnqOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725582591; c=relaxed/simple;
	bh=4ZK6Y0L46E329ybdQpbO/TKmYYczvuudgiPndMr7/s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpvofXZxHJ6Y2cZFdMvEQAq2Dt07Y+INvOzSUFJYdVtrVgrWMrfS48svNJgIjFNZS6IZzLLT7+DJg+LrHFDjvA/Q7HQaJDfUUsIojot3Rsobs40Sqy/s9EgAc7ywN+FihdVanez4NSN9vqjdH4GTS0HqC1mWlOheBvK8f6Mzq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Kw0GmmK3; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Kw0GmmK3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725582588;
	bh=MphT4C4bHD4orjy7XPvNclhjC+CK7I5wacnhSReDOEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=Kw0GmmK3JaHFycnIl1Kqtg08ES8hPeL8iahsjttDhhwPBdrG2tReJ+c9EoCa1W+MM
	 ROdg4HlC6W1aS7r03Bri76IJHSyHubOrPT+wg8t6mzBJSMHZSdPPprpDknrTdVxPB4
	 KowSiQfBogCu0Yos67zblEsI/T331LiGl6XO7wLEpD8remN6ivR8kDpfjzxOxyhoil
	 foMu54aMy4XOS9lrnATN+qdWTe5zuWRStSMXSEtKFTUBJMUbNnXotM9ohVto3ui6OW
	 SOyMjw5nCIIwer8RfsavGShihkZP+q+hjZLtiBeAb4DsIOVCFkjET4fys/JeBLQN1O
	 J2iful8XWPjmQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 407603A0315;
	Fri,  6 Sep 2024 00:29:40 +0000 (UTC)
Message-ID: <2d989071-18ba-40dd-835d-06689e2cd13a@icloud.com>
Date: Fri, 6 Sep 2024 08:29:37 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] net: qcom/emac: Find sgmii_ops by
 device_for_each_child()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-2-4180e1d5a244@quicinc.com>
 <2024090521-finch-skinny-69bc@gregkh>
 <2024090548-riverbank-resemble-6590@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024090548-riverbank-resemble-6590@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: U8RtFDwOMQI9JHogTBsBVbwW6bBNBQhw
X-Proofpoint-ORIG-GUID: U8RtFDwOMQI9JHogTBsBVbwW6bBNBQhw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2409060002

On 2024/9/5 13:33, Greg Kroah-Hartman wrote:
> On Thu, Sep 05, 2024 at 07:29:10AM +0200, Greg Kroah-Hartman wrote:
>> On Thu, Sep 05, 2024 at 08:36:10AM +0800, Zijun Hu wrote:
>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>
>>> To prepare for constifying the following old driver core API:
>>>
>>> struct device *device_find_child(struct device *dev, void *data,
>>> 		int (*match)(struct device *dev, void *data));
>>> to new:
>>> struct device *device_find_child(struct device *dev, const void *data,
>>> 		int (*match)(struct device *dev, const void *data));
>>>
>>> The new API does not allow its match function (*match)() to modify
>>> caller's match data @*data, but emac_sgmii_acpi_match() as the old
>>> API's match function indeed modifies relevant match data, so it is not
>>> suitable for the new API any more, solved by using device_for_each_child()
>>> to implement relevant finding sgmii_ops function.
>>>
>>> By the way, this commit does not change any existing logic.
>>>
>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>> ---
>>>  drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 22 +++++++++++++++++-----
>>>  1 file changed, 17 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
>>> index e4bc18009d08..29392c63d115 100644
>>> --- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
>>> +++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
>>> @@ -293,6 +293,11 @@ static struct sgmii_ops qdf2400_ops = {
>>>  };
>>>  #endif
>>>  
>>> +struct emac_match_data {
>>> +	struct sgmii_ops **sgmii_ops;
>>> +	struct device *target_device;
>>> +};
>>> +
>>>  static int emac_sgmii_acpi_match(struct device *dev, void *data)
>>>  {
>>>  #ifdef CONFIG_ACPI
>>> @@ -303,7 +308,7 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
>>>  		{}
>>>  	};
>>>  	const struct acpi_device_id *id = acpi_match_device(match_table, dev);
>>> -	struct sgmii_ops **ops = data;
>>> +	struct emac_match_data *match_data = data;
>>>  
>>>  	if (id) {
>>>  		acpi_handle handle = ACPI_HANDLE(dev);
>>> @@ -324,10 +329,12 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
>>>  
>>>  		switch (hrv) {
>>>  		case 1:
>>> -			*ops = &qdf2432_ops;
>>> +			*match_data->sgmii_ops = &qdf2432_ops;
>>> +			match_data->target_device = get_device(dev);
>>>  			return 1;
>>>  		case 2:
>>> -			*ops = &qdf2400_ops;
>>> +			*match_data->sgmii_ops = &qdf2400_ops;
>>> +			match_data->target_device = get_device(dev);
>>
>> Where is put_device() now called?
> 
> Nevermind, I see it now.
> 
> That being said, this feels wrong still, why not just do this "set up
> the ops" logic _after_ you find the device and not here in the match
> function?
> 
sorry, let me complement a little reply to last one.

This change will use emac_sgmii_acpi_match() as device_for_each_child()
function parameter, so may not regard emac_sgmii_acpi_match() as
match() function anymore.

> thanks,
> 
> greg k-h

