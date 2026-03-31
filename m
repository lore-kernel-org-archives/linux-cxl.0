Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B3536D4E1;
	Tue, 31 Mar 2026 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774934101; cv=none; b=KQfAEye1BPpf9j+7peacSSsgHuH+XXXbyeVBpChUUTj0vOu6X8PsaIJKaS4ynGmTgZkukGGqik7csO7ASNsixgsrOKLXZqpJgspDU9mEucFOk00dZrzNh1q/GhPmodun9I0OmlwULw8Cm9QRhAkzUAGsbJYyrl+52gO5fH6usIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774934101; c=relaxed/simple;
	bh=m6vXHv+hxo99iG5dI3XPQgsu3KBW43Y/f16iDN2u+fU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oY/Hck7+xL+Oni1cJivAijwF6V8SfgV3dv5EXDmhgAyHAsREQTNXTCtiDkSjOmPQMYU5+eLqQcmh9BuBIe/8v9AOIeEL28DWOmjfh7ILhWZWtBvMCb5EHQVJRx122T3mBa9tGnnovXUoaWMwKw4YK2DCoeLUg7BSpM2pD6wCiWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ho556UJ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ho556UJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D99C19423;
	Tue, 31 Mar 2026 05:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774934101;
	bh=m6vXHv+hxo99iG5dI3XPQgsu3KBW43Y/f16iDN2u+fU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ho556UJ4SsEPhuIGcdF7Uct6O2topnSDWm7A5jrm9fHUUZoLjR4jyti61bEgPG0Q1
	 4OXEw4DFFOnbRmMUHfw4qrOBpiJa+mCGf1eZPan+LaF0Y015vaIUfTauGzYOkJa0Qy
	 tK2NmGm5BwepW8Okt66rBmkMvBhSNiqBXkMwKYy0=
Date: Mon, 30 Mar 2026 22:15:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Li <hao.li@linux.dev>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, david@kernel.org,
 osalvador@suse.de, vbabka@suse.cz, joshua.hahnjy@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory_hotplug: maintain N_NORMAL_MEMORY during
 hotplug
Message-Id: <20260330221500.01d5466b26c969f460225bea@linux-foundation.org>
In-Reply-To: <ceqmspe2x2p5uv5bk3jyiw67qkyweaviclcjdp6kgwpg6v4kdq@f7yd6rr2lpkl>
References: <20260330035941.518186-1-hao.li@linux.dev>
	<aco0MtqpysMXMZdy@hyeyoo>
	<23feu42lqvc7iymgaxmnywea7c3qie5vmjm4aijbgdiazwvrcb@mmlxjowgtotv>
	<20260330144640.161ca53e94b37b3252de2e95@linux-foundation.org>
	<ceqmspe2x2p5uv5bk3jyiw67qkyweaviclcjdp6kgwpg6v4kdq@f7yd6rr2lpkl>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 12:24:46 +0800 Hao Li <hao.li@linux.dev> wrote:

> The most visible effect is that
> /sys/devices/system/node/has_normal_memory does not report a node even
> after that node has gained normal memory via hotplug.
> 
> Also, list_lru-based shrinkers can undercount objects on such a node and
> may skip reclaim on that node entirely, which can lead to a higher memory
> footprint than expected.
> 
> Feel free to fold the above into the changelog if useful :)

Very useful.  Added, thanks!
